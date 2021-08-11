Content-Type: multipart/mixed; boundary="===============5316776146957345472=="
MIME-Version: 1.0
From: nalso@naver.com
Subject: Question about static analysis
Date: Wed, 11 Aug 2021 02:56:29 +0000
Message-ID: <20210811025629.2797.34922@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5316776146957345472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone

Can I inquire here? If it's a problem, I'll delete it.

I have question about static analysis. below code, Why use after free? =

I can see modem.c and ussd.c,  simfs.c let me know if you have any intentio=
ns.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Use after free (USE_AFTER_FREE)
pass_freed_arg: Passing freed pointer found->data as an argument to g_slist=
_remove =


in modem.c
 	g_free(found->data);
	modem->interface_list =3D g_slist_remove(modem->interface_list,found->data=
);

	feature =3D get_feature(interface);
	if (feature) {
		found =3D g_slist_find_custom(modem->feature_list, feature,(GCompareFunc)=
 strcmp);

		if (found) {
			g_free(found->data);
			modem->feature_list =3D
				g_slist_remove(modem->feature_list,	found->data);
		}
	}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
in ussd.c
 	ssc_entry_destroy(l->data);
	ussd->ss_control_list =3D g_slist_remove(ussd->ss_control_list, l->data);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=

in simfs.c
			sim_fs_op_free(op);
			g_queue_remove(fs->op_q, op);
--===============5316776146957345472==--

