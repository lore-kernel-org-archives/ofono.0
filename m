Content-Type: multipart/mixed; boundary="===============3155116755794624374=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: Question about static analysis
Date: Wed, 11 Aug 2021 21:45:05 +0300
Message-ID: <62ca3f8c-672c-c3a3-d5b4-2f7256e3899c@jolla.com>
In-Reply-To: <20210811025629.2797.34922@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3155116755794624374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> Hi everyone
>
> Can I inquire here? If it's a problem, I'll delete it.
>
> I have question about static analysis. below code, Why use after free?
> I can see modem.c and ussd.c,  simfs.c let me know if you have any intent=
ions.

g_slist_remove() doesn't actually access the pointer. It doesn't even =

assume that it's a valid pointer (it could be an int cast to a pointer, =

for example). There's no danger whatsoever in freeing the memory first =

and then passing the pointer to g_slist_remove()

Although it would probably be cleaner to use g_slist_delete_link() for =

the found link, instead of g_slist_remove()

Cheers,

-Slava


> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Use after free (USE_AFTER_FREE)
> pass_freed_arg: Passing freed pointer found->data as an argument to g_sli=
st_remove
>
> in modem.c
>   	g_free(found->data);
> 	modem->interface_list =3D g_slist_remove(modem->interface_list,found->da=
ta);
>
> 	feature =3D get_feature(interface);
> 	if (feature) {
> 		found =3D g_slist_find_custom(modem->feature_list, feature,(GCompareFun=
c) strcmp);
>
> 		if (found) {
> 			g_free(found->data);
> 			modem->feature_list =3D
> 				g_slist_remove(modem->feature_list,	found->data);
> 		}
> 	}
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> in ussd.c
>   	ssc_entry_destroy(l->data);
> 	ussd->ss_control_list =3D g_slist_remove(ussd->ss_control_list, l->data);
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=

> in simfs.c
> 			sim_fs_op_free(op);
> 			g_queue_remove(fs->op_q, op);
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
> .
--===============3155116755794624374==--

