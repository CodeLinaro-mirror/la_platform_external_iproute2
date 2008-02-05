/*
 * tc_tree.c		TC utility functions for tree format
 *
 *		This program is free software; you can redistribute it and/or
 *		modify it under the terms of the GNU General Public License
 *		as published by the Free Software Foundation; either version
 *		2 of the License, or (at your option) any later version.
 *
 * Authors:	Stephen Hemminger <stephen.hemminger@vyatta.com>
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <syslog.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>

#include "utils.h"
#include "tc_util.h"

int insert_tree(struct node **root, const struct tcmsg *t, 
		const struct rtattr *tb, int len)
{
	struct node *p = malloc(sizeof(*p) + len);
	if (!p) 
		goto nomem;

	p->next = *root;
	p->ifindex = t->tcm_ifindex;
	p->handle = t->tcm_handle;
	p->parent = t->tcm_parent;
	p->info	  = t->tcm_info;
	memcpy(p->tca, tb, p->len = len);
	*root = p;

	return 0;
nomem:
	fprintf(stderr, "No memory\n");
	return -1;
}

void free_tree(struct node *root)
{
	struct node *p, *n;

	for (p = root; p; p = n) {
		n = p->next;
		free(p);
	}
}

static int count_list(const struct node *head)
{
	const struct node *p;
	int count = 0;

	for (p = head; p; p = p->next)
		++count;

	return count;
}

static int compare_node(const void *p1, const void *p2)
{
	const struct node *n1 = *((const struct node **)p1);
	const struct node *n2 = *((const struct node **)p2);

	if (n1->ifindex != n2->ifindex)
		return n1->ifindex - n2->ifindex;
	
	if (n1->parent == TC_H_ROOT)
		return -1;
	if (n2->parent == TC_H_ROOT)
		return 1;

	if (n1->parent < n2->parent)
		return -1;
	if (n1->parent > n2->parent)
		return 1;

	return (n1->handle >> 16) - (n2->handle >> 16);
}

static struct node *sort_nodes(struct node *head)
{
	int i, cnt = count_list(head);
	struct node *p, **q, **index, **tail;
	
	/* build index */
	q = index = alloca(cnt * sizeof(*q));
	for (p = head; p; ++i, p = p->next)
		*q++ = p;

	/* sort it */
	qsort(index, cnt, sizeof(*q), compare_node);
	
	/* rebuild list */
	head = NULL;
	tail = &head;
	for (i = 0; i < cnt; i++) {
		*tail = p = index[i];
		tail = &p->next;
	}
	*tail = NULL;
	return head;
}

static void put_indent(int n)
{
	while (n--)
		putchar(' ');
}

static inline int same_major(uint32_t h1, uint32_t h2)
{
	return h1 >> 16 == h2 >> 16;
}

void print_tree(struct node *root, void (*display)(const struct node *))
{
	struct node *n, *last = NULL;
	int indent = 0;

	root = sort_nodes(root);

	for (n = root; n; n = n->next) {
//		printf("%d:%08x:%08x ", n->ifindex, n->parent, n->handle);

		/* put device at start of line */
		if (!last || last->ifindex != n->ifindex)
			indent = printf("%s -", ll_index_to_name(n->ifindex));
		else
			put_indent(indent);
		
		printf("+-%04x- ", n->handle >> 16);
		display(n);

		if (n->next && !same_major(n->next->parent, n->parent)) {
			if (same_major(n->handle, n->next->parent))
				indent += 8;
			else
				indent -= 8;
		}
		last = n;
	}
}

