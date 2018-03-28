Content-Type: multipart/mixed; boundary="===============5569999930061617152=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 12/30] qmi: replace GQueues for requests
Date: Wed, 28 Mar 2018 20:59:58 +0200
Message-ID: <20180328190016.28509-13-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5569999930061617152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This brings in list.h from the Linux kernel and replaces the GQueues
used for enqueuing requests with struct list_heads.  These list
operations are both more efficient and generally easier to work with.
Since ofono and Linux share a common license, this code borrowing should
not be problematic in any way.
---
 drivers/qmimodem/list.h | 736 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/qmi.c  | 172 ++++++-----
 2 files changed, 820 insertions(+), 88 deletions(-)
 create mode 100644 drivers/qmimodem/list.h

diff --git a/drivers/qmimodem/list.h b/drivers/qmimodem/list.h
new file mode 100644
index 00000000..d5dddcc1
--- /dev/null
+++ b/drivers/qmimodem/list.h
@@ -0,0 +1,736 @@
+#ifndef __POC_LIST_H
+#define __POC_LIST_H
+
+#include <stdlib.h>
+#include <stddef.h>
+
+#ifndef __GNUC__
+#error list.h relies on GCC extensions...
+#endif
+
+/**
+ * container_of - cast a member of a structure out to the containing struc=
ture
+ * @ptr:	the pointer to the member.
+ * @type:	the type of the container struct this is embedded in.
+ * @member:	the name of the member within the struct.
+ *
+ */
+#define container_of(ptr, type, member) ({			\
+	const typeof( ((type *)0)->member ) *__mptr =3D (ptr);	\
+	(type *)(void *)( (char *)__mptr - offsetof(type,member) );})
+
+#define LIST_POISON1 0
+#define LIST_POISON2 0
+
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+struct hlist_head {
+	struct hlist_node *first;
+};
+
+struct hlist_node {
+	struct hlist_node *next, **pprev;
+};
+
+/*
+ * Simple doubly linked list implementation.
+ *
+ * Some of the internal functions ("__xxx") are useful when
+ * manipulating whole lists rather than single entries, as
+ * sometimes we already know the next/prev entries and we can
+ * generate better code by using them directly rather than
+ * using the generic single-entry routines.
+ */
+
+#define LIST_HEAD_INIT(name) { &(name), &(name) }
+
+#define LIST_HEAD(name) \
+	struct list_head name =3D LIST_HEAD_INIT(name)
+
+static inline void INIT_LIST_HEAD(struct list_head *list)
+{
+	list->next =3D list;
+	list->prev =3D list;
+}
+
+/*
+ * Insert a new entry between two known consecutive entries.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static inline void __list_add(struct list_head *new,
+			      struct list_head *prev,
+			      struct list_head *next)
+{
+	next->prev =3D new;
+	new->next =3D next;
+	new->prev =3D prev;
+	prev->next =3D new;
+}
+
+/**
+ * list_add - add a new entry
+ * @new: new entry to be added
+ * @head: list head to add it after
+ *
+ * Insert a new entry after the specified head.
+ * This is good for implementing stacks.
+ */
+static inline void list_add(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head, head->next);
+}
+
+
+/**
+ * list_add_tail - add a new entry
+ * @new: new entry to be added
+ * @head: list head to add it before
+ *
+ * Insert a new entry before the specified head.
+ * This is useful for implementing queues.
+ */
+static inline void list_add_tail(struct list_head *new, struct list_head *=
head)
+{
+	__list_add(new, head->prev, head);
+}
+
+/*
+ * Delete a list entry by making the prev/next entries
+ * point to each other.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static inline void __list_del(struct list_head * prev, struct list_head * =
next)
+{
+	next->prev =3D prev;
+	prev->next =3D next;
+}
+
+/**
+ * list_del - deletes entry from list.
+ * @entry: the element to delete from the list.
+ * Note: list_empty() on entry does not return true after this, the entry =
is
+ * in an undefined state.
+ */
+static inline void __list_del_entry(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+}
+
+static inline void list_del(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	entry->next =3D LIST_POISON1;
+	entry->prev =3D LIST_POISON2;
+}
+
+/**
+ * list_replace - replace old entry by new one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * If @old was empty, it will be overwritten.
+ */
+static inline void list_replace(struct list_head *old,
+				struct list_head *new)
+{
+	new->next =3D old->next;
+	new->next->prev =3D new;
+	new->prev =3D old->prev;
+	new->prev->next =3D new;
+}
+
+static inline void list_replace_init(struct list_head *old,
+					struct list_head *new)
+{
+	list_replace(old, new);
+	INIT_LIST_HEAD(old);
+}
+
+/**
+ * list_del_init - deletes entry from list and reinitialize it.
+ * @entry: the element to delete from the list.
+ */
+static inline void list_del_init(struct list_head *entry)
+{
+	__list_del_entry(entry);
+	INIT_LIST_HEAD(entry);
+}
+
+/**
+ * list_move - delete from one list and add as another's head
+ * @list: the entry to move
+ * @head: the head that will precede our entry
+ */
+static inline void list_move(struct list_head *list, struct list_head *hea=
d)
+{
+	__list_del_entry(list);
+	list_add(list, head);
+}
+
+/**
+ * list_move_tail - delete from one list and add as another's tail
+ * @list: the entry to move
+ * @head: the head that will follow our entry
+ */
+static inline void list_move_tail(struct list_head *list,
+				  struct list_head *head)
+{
+	__list_del_entry(list);
+	list_add_tail(list, head);
+}
+
+/**
+ * list_is_last - tests whether @list is the last entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_last(const struct list_head *list,
+				const struct list_head *head)
+{
+	return list->next =3D=3D head;
+}
+
+/**
+ * list_empty - tests whether a list is empty
+ * @head: the list to test.
+ */
+static inline int list_empty(const struct list_head *head)
+{
+	return head->next =3D=3D head;
+}
+
+/**
+ * list_empty_careful - tests whether a list is empty and not being modifi=
ed
+ * @head: the list to test
+ *
+ * Description:
+ * tests whether a list is empty _and_ checks that no other CPU might be
+ * in the process of modifying either member (next or prev)
+ *
+ * NOTE: using list_empty_careful() without synchronization
+ * can only be safe if the only activity that can happen
+ * to the list entry is list_del_init(). Eg. it cannot be used
+ * if another CPU could re-list_add() it.
+ */
+static inline int list_empty_careful(const struct list_head *head)
+{
+	struct list_head *next =3D head->next;
+	return (next =3D=3D head) && (next =3D=3D head->prev);
+}
+
+/**
+ * list_rotate_left - rotate the list to the left
+ * @head: the head of the list
+ */
+static inline void list_rotate_left(struct list_head *head)
+{
+	struct list_head *first;
+
+	if (!list_empty(head)) {
+		first =3D head->next;
+		list_move_tail(first, head);
+	}
+}
+
+/**
+ * list_is_singular - tests whether a list has just one entry.
+ * @head: the list to test.
+ */
+static inline int list_is_singular(const struct list_head *head)
+{
+	return !list_empty(head) && (head->next =3D=3D head->prev);
+}
+
+static inline void __list_cut_position(struct list_head *list,
+		struct list_head *head, struct list_head *entry)
+{
+	struct list_head *new_first =3D entry->next;
+	list->next =3D head->next;
+	list->next->prev =3D list;
+	list->prev =3D entry;
+	entry->next =3D list;
+	head->next =3D new_first;
+	new_first->prev =3D head;
+}
+
+/**
+ * list_cut_position - cut a list into two
+ * @list: a new list to add all removed entries
+ * @head: a list with entries
+ * @entry: an entry within head, could be the head itself
+ *	and if so we won't cut the list
+ *
+ * This helper moves the initial part of @head, up to and
+ * including @entry, from @head to @list. You should
+ * pass on @entry an element you know is on @head. @list
+ * should be an empty list or a list you do not care about
+ * losing its data.
+ *
+ */
+static inline void list_cut_position(struct list_head *list,
+		struct list_head *head, struct list_head *entry)
+{
+	if (list_empty(head))
+		return;
+	if (list_is_singular(head) &&
+		(head->next !=3D entry && head !=3D entry))
+		return;
+	if (entry =3D=3D head)
+		INIT_LIST_HEAD(list);
+	else
+		__list_cut_position(list, head, entry);
+}
+
+static inline void __list_splice(const struct list_head *list,
+				 struct list_head *prev,
+				 struct list_head *next)
+{
+	struct list_head *first =3D list->next;
+	struct list_head *last =3D list->prev;
+
+	first->prev =3D prev;
+	prev->next =3D first;
+
+	last->next =3D next;
+	next->prev =3D last;
+}
+
+/**
+ * list_splice - join two lists, this is designed for stacks
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ */
+static inline void list_splice(const struct list_head *list,
+				struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice(list, head, head->next);
+}
+
+/**
+ * list_splice_tail - join two lists, each list being a queue
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ */
+static inline void list_splice_tail(struct list_head *list,
+				struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice(list, head->prev, head);
+}
+
+/**
+ * list_splice_init - join two lists and reinitialise the emptied list.
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ *
+ * The list at @list is reinitialised
+ */
+static inline void list_splice_init(struct list_head *list,
+				    struct list_head *head)
+{
+	if (!list_empty(list)) {
+		__list_splice(list, head, head->next);
+		INIT_LIST_HEAD(list);
+	}
+}
+
+/**
+ * list_splice_tail_init - join two lists and reinitialise the emptied list
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ *
+ * Each of the lists is a queue.
+ * The list at @list is reinitialised
+ */
+static inline void list_splice_tail_init(struct list_head *list,
+					 struct list_head *head)
+{
+	if (!list_empty(list)) {
+		__list_splice(list, head->prev, head);
+		INIT_LIST_HEAD(list);
+	}
+}
+
+/**
+ * list_entry - get the struct for this entry
+ * @ptr:	the &struct list_head pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_entry(ptr, type, member) \
+	container_of(ptr, type, member)
+
+/**
+ * list_first_entry - get the first element from a list
+ * @ptr:	the list head to take the element from.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Note, that list is expected to be not empty.
+ */
+#define list_first_entry(ptr, type, member) \
+	list_entry((ptr)->next, type, member)
+
+/**
+ * list_for_each	-	iterate over a list
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ */
+#define list_for_each(pos, head) \
+	for (pos =3D (head)->next; pos !=3D (head); pos =3D pos->next)
+
+/**
+ * __list_for_each	-	iterate over a list
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ *
+ * This variant doesn't differ from list_for_each() any more.
+ * We don't do prefetching in either case.
+ */
+#define __list_for_each(pos, head) \
+	for (pos =3D (head)->next; pos !=3D (head); pos =3D pos->next)
+
+/**
+ * list_for_each_prev	-	iterate over a list backwards
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ */
+#define list_for_each_prev(pos, head) \
+	for (pos =3D (head)->prev; pos !=3D (head); pos =3D pos->prev)
+
+/**
+ * list_for_each_safe - iterate over a list safe against removal of list e=
ntry
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @n:		another &struct list_head to use as temporary storage
+ * @head:	the head for your list.
+ */
+#define list_for_each_safe(pos, n, head) \
+	for (pos =3D (head)->next, n =3D pos->next; pos !=3D (head); \
+		pos =3D n, n =3D pos->next)
+
+/**
+ * list_for_each_prev_safe - iterate over a list backwards safe against re=
moval of list entry
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @n:		another &struct list_head to use as temporary storage
+ * @head:	the head for your list.
+ */
+#define list_for_each_prev_safe(pos, n, head) \
+	for (pos =3D (head)->prev, n =3D pos->prev; \
+	     pos !=3D (head); \
+	     pos =3D n, n =3D pos->prev)
+
+/**
+ * list_for_each_entry	-	iterate over list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry(pos, head, member)				\
+	for (pos =3D list_entry((head)->next, typeof(*pos), member);	\
+	     &pos->member !=3D (head); 	\
+	     pos =3D list_entry(pos->member.next, typeof(*pos), member))
+
+/**
+ * list_for_each_entry_reverse - iterate backwards over list of given type.
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_reverse(pos, head, member)			\
+	for (pos =3D list_entry((head)->prev, typeof(*pos), member);	\
+	     &pos->member !=3D (head); 	\
+	     pos =3D list_entry(pos->member.prev, typeof(*pos), member))
+
+/**
+ * list_prepare_entry - prepare a pos entry for use in list_for_each_entry=
_continue()
+ * @pos:	the type * to use as a start point
+ * @head:	the head of the list
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Prepares a pos entry for use as a start point in list_for_each_entry_co=
ntinue().
+ */
+#define list_prepare_entry(pos, head, member) \
+	((pos) ? : list_entry(head, typeof(*pos), member))
+
+/**
+ * list_for_each_entry_continue - continue iteration over list of given ty=
pe
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Continue to iterate over list of given type, continuing after
+ * the current position.
+ */
+#define list_for_each_entry_continue(pos, head, member) 		\
+	for (pos =3D list_entry(pos->member.next, typeof(*pos), member);	\
+	     &pos->member !=3D (head);	\
+	     pos =3D list_entry(pos->member.next, typeof(*pos), member))
+
+/**
+ * list_for_each_entry_continue_reverse - iterate backwards from the given=
 point
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Start to iterate over list of given type backwards, continuing after
+ * the current position.
+ */
+#define list_for_each_entry_continue_reverse(pos, head, member)		\
+	for (pos =3D list_entry(pos->member.prev, typeof(*pos), member);	\
+	     &pos->member !=3D (head);	\
+	     pos =3D list_entry(pos->member.prev, typeof(*pos), member))
+
+/**
+ * list_for_each_entry_from - iterate over list of given type from the cur=
rent point
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Iterate over list of given type, continuing from current position.
+ */
+#define list_for_each_entry_from(pos, head, member) 			\
+	for (; &pos->member !=3D (head);	\
+	     pos =3D list_entry(pos->member.next, typeof(*pos), member))
+
+/**
+ * list_for_each_entry_safe - iterate over list of given type safe against=
 removal of list entry
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos =3D list_entry((head)->next, typeof(*pos), member),	\
+		n =3D list_entry(pos->member.next, typeof(*pos), member);	\
+	     &pos->member !=3D (head); 					\
+	     pos =3D n, n =3D list_entry(n->member.next, typeof(*n), member))
+
+/**
+ * list_for_each_entry_safe_continue - continue list iteration safe agains=
t removal
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Iterate over list of given type, continuing after current point,
+ * safe against removal of list entry.
+ */
+#define list_for_each_entry_safe_continue(pos, n, head, member) 		\
+	for (pos =3D list_entry(pos->member.next, typeof(*pos), member), 		\
+		n =3D list_entry(pos->member.next, typeof(*pos), member);		\
+	     &pos->member !=3D (head);						\
+	     pos =3D n, n =3D list_entry(n->member.next, typeof(*n), member))
+
+/**
+ * list_for_each_entry_safe_from - iterate over list from current point sa=
fe against removal
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Iterate over list of given type from current point, safe against
+ * removal of list entry.
+ */
+#define list_for_each_entry_safe_from(pos, n, head, member) 			\
+	for (n =3D list_entry(pos->member.next, typeof(*pos), member);		\
+	     &pos->member !=3D (head);						\
+	     pos =3D n, n =3D list_entry(n->member.next, typeof(*n), member))
+
+/**
+ * list_for_each_entry_safe_reverse - iterate backwards over list safe aga=
inst removal
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * Iterate backwards over list of given type, safe against removal
+ * of list entry.
+ */
+#define list_for_each_entry_safe_reverse(pos, n, head, member)		\
+	for (pos =3D list_entry((head)->prev, typeof(*pos), member),	\
+		n =3D list_entry(pos->member.prev, typeof(*pos), member);	\
+	     &pos->member !=3D (head); 					\
+	     pos =3D n, n =3D list_entry(n->member.prev, typeof(*n), member))
+
+/**
+ * list_safe_reset_next - reset a stale list_for_each_entry_safe loop
+ * @pos:	the loop cursor used in the list_for_each_entry_safe loop
+ * @n:		temporary storage used in list_for_each_entry_safe
+ * @member:	the name of the list_struct within the struct.
+ *
+ * list_safe_reset_next is not safe to use in general if the list may be
+ * modified concurrently (eg. the lock is dropped in the loop body). An
+ * exception to this is if the cursor element (pos) is pinned in the list,
+ * and list_safe_reset_next is called after re-taking the lock and before
+ * completing the current iteration of the loop body.
+ */
+#define list_safe_reset_next(pos, n, member)				\
+	n =3D list_entry(pos->member.next, typeof(*pos), member)
+
+/*
+ * Double linked lists with a single pointer list head.
+ * Mostly useful for hash tables where the two pointer list head is
+ * too wasteful.
+ * You lose the ability to access the tail in O(1).
+ */
+
+#define HLIST_HEAD_INIT { .first =3D NULL }
+#define HLIST_HEAD(name) struct hlist_head name =3D {  .first =3D NULL }
+#define INIT_HLIST_HEAD(ptr) ((ptr)->first =3D NULL)
+static inline void INIT_HLIST_NODE(struct hlist_node *h)
+{
+	h->next =3D NULL;
+	h->pprev =3D NULL;
+}
+
+static inline int hlist_unhashed(const struct hlist_node *h)
+{
+	return !h->pprev;
+}
+
+static inline int hlist_empty(const struct hlist_head *h)
+{
+	return !h->first;
+}
+
+static inline void __hlist_del(struct hlist_node *n)
+{
+	struct hlist_node *next =3D n->next;
+	struct hlist_node **pprev =3D n->pprev;
+	*pprev =3D next;
+	if (next)
+		next->pprev =3D pprev;
+}
+
+static inline void hlist_del(struct hlist_node *n)
+{
+	__hlist_del(n);
+	n->next =3D LIST_POISON1;
+	n->pprev =3D LIST_POISON2;
+}
+
+static inline void hlist_del_init(struct hlist_node *n)
+{
+	if (!hlist_unhashed(n)) {
+		__hlist_del(n);
+		INIT_HLIST_NODE(n);
+	}
+}
+
+static inline void hlist_add_head(struct hlist_node *n, struct hlist_head =
*h)
+{
+	struct hlist_node *first =3D h->first;
+	n->next =3D first;
+	if (first)
+		first->pprev =3D &n->next;
+	h->first =3D n;
+	n->pprev =3D &h->first;
+}
+
+/* next must be !=3D NULL */
+static inline void hlist_add_before(struct hlist_node *n,
+					struct hlist_node *next)
+{
+	n->pprev =3D next->pprev;
+	n->next =3D next;
+	next->pprev =3D &n->next;
+	*(n->pprev) =3D n;
+}
+
+static inline void hlist_add_after(struct hlist_node *n,
+					struct hlist_node *next)
+{
+	next->next =3D n->next;
+	n->next =3D next;
+	next->pprev =3D &n->next;
+
+	if(next->next)
+		next->next->pprev  =3D &next->next;
+}
+
+/* after that we'll appear to be on some hlist and hlist_del will work */
+static inline void hlist_add_fake(struct hlist_node *n)
+{
+	n->pprev =3D &n->next;
+}
+
+/*
+ * Move a list from one list head to another. Fixup the pprev
+ * reference of the first entry if it exists.
+ */
+static inline void hlist_move_list(struct hlist_head *old,
+				   struct hlist_head *new)
+{
+	new->first =3D old->first;
+	if (new->first)
+		new->first->pprev =3D &new->first;
+	old->first =3D NULL;
+}
+
+#define hlist_entry(ptr, type, member) container_of(ptr,type,member)
+
+#define hlist_for_each(pos, head) \
+	for (pos =3D (head)->first; pos ; pos =3D pos->next)
+
+#define hlist_for_each_safe(pos, n, head) \
+	for (pos =3D (head)->first; pos && ({ n =3D pos->next; 1; }); \
+	     pos =3D n)
+
+/**
+ * hlist_for_each_entry	- iterate over list of given type
+ * @tpos:	the type * to use as a loop cursor.
+ * @pos:	the &struct hlist_node to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry(tpos, pos, head, member)			 \
+	for (pos =3D (head)->first;					 \
+	     pos &&							 \
+		({ tpos =3D hlist_entry(pos, typeof(*tpos), member); 1;}); \
+	     pos =3D pos->next)
+
+/**
+ * hlist_for_each_entry_continue - iterate over a hlist continuing after c=
urrent point
+ * @tpos:	the type * to use as a loop cursor.
+ * @pos:	the &struct hlist_node to use as a loop cursor.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry_continue(tpos, pos, member)		 \
+	for (pos =3D (pos)->next;						 \
+	     pos &&							 \
+		({ tpos =3D hlist_entry(pos, typeof(*tpos), member); 1;}); \
+	     pos =3D pos->next)
+
+/**
+ * hlist_for_each_entry_from - iterate over a hlist continuing from curren=
t point
+ * @tpos:	the type * to use as a loop cursor.
+ * @pos:	the &struct hlist_node to use as a loop cursor.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry_from(tpos, pos, member)			 \
+	for (; pos &&							 \
+		({ tpos =3D hlist_entry(pos, typeof(*tpos), member); 1;}); \
+	     pos =3D pos->next)
+
+/**
+ * hlist_for_each_entry_safe - iterate over list of given type safe agains=
t removal of list entry
+ * @tpos:	the type * to use as a loop cursor.
+ * @pos:	the &struct hlist_node to use as a loop cursor.
+ * @n:		another &struct hlist_node to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry_safe(tpos, pos, n, head, member) 		 \
+	for (pos =3D (head)->first;					 \
+	     pos && ({ n =3D pos->next; 1; }) && 				 \
+		({ tpos =3D hlist_entry(pos, typeof(*tpos), member); 1;}); \
+	     pos =3D n)
+
+#endif
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5ed41e0a..e11e05b1 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -37,6 +37,8 @@
 =

 #include <ofono/log.h>
 =

+#include "list.h"
+
 #include "qmi.h"
 #include "ctl.h"
 =

@@ -54,9 +56,9 @@ struct qmi_device {
 	bool close_on_unref;
 	guint read_watch;
 	guint write_watch;
-	GQueue *req_queue;
-	GQueue *control_queue;
-	GQueue *service_queue;
+	struct list_head req_queue;
+	struct list_head control_queue;
+	struct list_head service_queue;
 	GQueue *discovery_queue;
 	uint8_t next_control_tid;
 	uint16_t next_service_tid;
@@ -102,6 +104,7 @@ struct qmi_result {
 };
 =

 struct qmi_request {
+	struct list_head node;
 	uint16_t tid;
 	uint8_t client;
 	void *buf;
@@ -172,6 +175,7 @@ static int __request_submit(struct qmi_device* device,
 	uint16_t headroom;
 =

 	req =3D calloc(1, sizeof(*req));
+	INIT_LIST_HEAD(&req->node);
 =

 	if (service =3D=3D QMI_SERVICE_CONTROL)
 		headroom =3D QMI_CONTROL_HDR_SIZE;
@@ -223,7 +227,7 @@ static int __request_submit(struct qmi_device* device,
 		req->tid =3D hdr->transaction;
 	}
 =

-	g_queue_push_tail(device->req_queue, req);
+	list_add_tail(&req->node, &device->req_queue);
 =

 	wakeup_writer(device);
 =

@@ -238,12 +242,17 @@ static void __request_free(gpointer data, gpointer us=
er_data)
 	g_free(req);
 }
 =

-static gint __request_compare(gconstpointer a, gconstpointer b)
+static struct qmi_request* __request_find_by_tid(struct list_head *queue,
+						uint16_t tid)
 {
-	const struct qmi_request *req =3D a;
-	uint16_t tid =3D GPOINTER_TO_UINT(b);
+	struct qmi_request* req;
+
+	list_for_each_entry(req, queue, node) {
+		if (req->tid =3D=3D tid)
+			return req;
+	}
 =

-	return req->tid - tid;
+	return NULL;
 }
 =

 static void __discovery_free(gpointer data, gpointer user_data)
@@ -662,10 +671,11 @@ static gboolean can_write_data(GIOChannel *channel, G=
IOCondition cond,
 	struct qmi_request *req;
 	ssize_t bytes_written;
 =

-	req =3D g_queue_pop_head(device->req_queue);
-	if (!req)
+	if (list_empty(&device->req_queue))
 		return FALSE;
 =

+	req =3D list_first_entry(&device->req_queue, struct qmi_request, node);
+
 	bytes_written =3D write(device->fd, req->buf, req->len);
 	if (bytes_written < 0)
 		return FALSE;
@@ -679,14 +689,14 @@ static gboolean can_write_data(GIOChannel *channel, G=
IOCondition cond,
 	hdr =3D req->buf;
 =

 	if (hdr->service =3D=3D QMI_SERVICE_CONTROL)
-		g_queue_push_tail(device->control_queue, req);
+		list_move(&req->node, &device->control_queue);
 	else
-		g_queue_push_tail(device->service_queue, req);
+		list_move(&req->node, &device->service_queue);
 =

 	g_free(req->buf);
 	req->buf =3D NULL;
 =

-	if (g_queue_get_length(device->req_queue) > 0)
+	if (!list_empty(&device->req_queue))
 		return TRUE;
 =

 	return FALSE;
@@ -768,7 +778,6 @@ static void handle_packet(struct qmi_device *device,
 		const struct qmi_control_hdr *control =3D buf;
 		const struct qmi_message_hdr *msg;
 		unsigned int tid;
-		GList *list;
 =

 		/* Ignore control messages with client identifier */
 		if (hdr->client !=3D 0x00)
@@ -789,19 +798,15 @@ static void handle_packet(struct qmi_device *device,
 			return;
 		}
 =

-		list =3D g_queue_find_custom(device->control_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
-		if (!list)
+		req =3D __request_find_by_tid(&device->control_queue, tid);
+		if (!req)
 			return;
 =

-		req =3D list->data;
-
-		g_queue_delete_link(device->control_queue, list);
+		list_del(&req->node);
 	} else {
 		const struct qmi_service_hdr *service =3D buf;
 		const struct qmi_message_hdr *msg;
 		unsigned int tid;
-		GList *list;
 =

 		msg =3D buf + QMI_SERVICE_HDR_SIZE;
 =

@@ -818,14 +823,11 @@ static void handle_packet(struct qmi_device *device,
 			return;
 		}
 =

-		list =3D g_queue_find_custom(device->service_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
-		if (!list)
+		req =3D __request_find_by_tid(&device->service_queue, tid);
+		if (!req)
 			return;
 =

-		req =3D list->data;
-
-		g_queue_delete_link(device->service_queue, list);
+		list_del(&req->node);
 	}
 =

 	if (req->callback)
@@ -957,9 +959,9 @@ struct qmi_device *qmi_device_new(int fd)
 =

 	g_io_channel_unref(device->io);
 =

-	device->req_queue =3D g_queue_new();
-	device->control_queue =3D g_queue_new();
-	device->service_queue =3D g_queue_new();
+	INIT_LIST_HEAD(&device->req_queue);
+	INIT_LIST_HEAD(&device->control_queue);
+	INIT_LIST_HEAD(&device->service_queue);
 	device->discovery_queue =3D g_queue_new();
 =

 	device->service_list =3D g_hash_table_new_full(g_direct_hash,
@@ -983,6 +985,8 @@ struct qmi_device *qmi_device_ref(struct qmi_device *de=
vice)
 =

 void qmi_device_unref(struct qmi_device *device)
 {
+	struct qmi_request *req, *req_t;
+
 	if (!device)
 		return;
 =

@@ -991,14 +995,32 @@ void qmi_device_unref(struct qmi_device *device)
 =

 	__debug_device(device, "device %p free", device);
 =

-	g_queue_foreach(device->control_queue, __request_free, NULL);
-	g_queue_free(device->control_queue);
+	list_for_each_entry_safe(req, req_t, &device->control_queue, node) {
+		/* FIXME: this fails to free user data attached to the
+		 * request with a 'destroy' function
+		 */
+		list_del(&req->node);
+		g_free(req->buf);
+		g_free(req);
+	}
 =

-	g_queue_foreach(device->service_queue, __request_free, NULL);
-	g_queue_free(device->service_queue);
+	list_for_each_entry_safe(req, req_t, &device->service_queue, node) {
+		/* FIXME: this fails to free user data attached to the
+		 * request with a 'destroy' function
+		 */
+		list_del(&req->node);
+		g_free(req->buf);
+		g_free(req);
+	}
 =

-	g_queue_foreach(device->req_queue, __request_free, NULL);
-	g_queue_free(device->req_queue);
+	list_for_each_entry_safe(req, req_t, &device->req_queue, node) {
+		/* FIXME: this fails to free user data attached to the
+		 * request with a 'destroy' function
+		 */
+		list_del(&req->node);
+		g_free(req->buf);
+		g_free(req);
+	}
 =

 	g_queue_foreach(device->discovery_queue, __discovery_free, NULL);
 	g_queue_free(device->discovery_queue);
@@ -1008,7 +1030,7 @@ void qmi_device_unref(struct qmi_device *device)
 =

 	if (device->read_watch > 0)
 		g_source_remove(device->read_watch);
-
+ =

 	if (device->close_on_unref)
 		close(device->fd);
 =

@@ -1194,29 +1216,17 @@ static gboolean discover_reply(gpointer user_data)
 	struct discover_data *data =3D user_data;
 	struct qmi_device *device =3D data->device;
 	unsigned int tid =3D data->tid;
-	GList *list;
 	struct qmi_request *req =3D NULL;
 =

 	data->timeout =3D 0;
 =

 	/* remove request from queues */
 	if (tid !=3D 0) {
-		list =3D g_queue_find_custom(device->req_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
+		req =3D __request_find_by_tid(&device->req_queue, tid);
+		if (!req) =

+			req =3D __request_find_by_tid(&device->control_queue,tid);
 =

-		if (list) {
-			req =3D list->data;
-			g_queue_delete_link(device->req_queue, list);
-		} else {
-			list =3D g_queue_find_custom(device->control_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
-
-			if (list) {
-				req =3D list->data;
-				g_queue_delete_link(device->control_queue,
-								list);
-			}
-		}
+		list_del(&req->node);
 	}
 =

 	if (data->func)
@@ -2274,40 +2284,10 @@ uint16_t qmi_service_send(struct qmi_service *servi=
ce,
 	return 1;
 }
 =

-static GQueue *remove_client(GQueue *queue, uint8_t client)
-{
-	GQueue *new_queue;
-	GList *list;
-
-	new_queue =3D g_queue_new();
-
-	while (1) {
-		struct qmi_request *req;
-
-		list =3D g_queue_pop_head_link(queue);
-		if (!list)
-			break;
-
-		req =3D list->data;
-
-		if (!req->client || req->client !=3D client) {
-			g_queue_push_tail_link(new_queue, list);
-			continue;
-		}
-
-		service_send_free(req->user_data);
-
-		__request_free(req, NULL);
-	}
-
-	g_queue_free(queue);
-
-	return new_queue;
-}
-
 bool qmi_service_cancel_all(struct qmi_service *service)
 {
 	struct qmi_device *device;
+	struct qmi_request *req, *req_t;
 =

 	if (!service)
 		return false;
@@ -2319,11 +2299,27 @@ bool qmi_service_cancel_all(struct qmi_service *ser=
vice)
 	if (!device)
 		return false;
 =

-	device->req_queue =3D remove_client(device->req_queue,
-						service->client_id);
+	list_for_each_entry_safe(req, req_t, &device->req_queue, node) {
+		if (req->client =3D=3D service->client_id) {
+			list_del(&req->node);
+
+			service_send_free(req->user_data);
+
+			g_free(req->buf);
+			g_free(req);
+		}
+	}
+
+	list_for_each_entry_safe(req, req_t, &device->service_queue, node) {
+		if (req->client =3D=3D service->client_id) {
+			list_del(&req->node);
+
+			service_send_free(req->user_data);
 =

-	device->service_queue =3D remove_client(device->service_queue,
-							service->client_id);
+			g_free(req->buf);
+			g_free(req);
+		}
+	}
 =

 	return true;
 }
-- =

2.15.1


--===============5569999930061617152==--

