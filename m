Content-Type: multipart/mixed; boundary="===============5846872541649990024=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: [RFC PATCH 1/2] smsutil: Status Report assembly
Date: Fri, 11 Jun 2010 14:35:24 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A5A@jklmail01.ixonos.local>
In-Reply-To: <201006101152.46861.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5846872541649990024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
> Hi Pasi,
> =

> > +void status_report_assembly_free(struct status_report_assembly *assemb=
ly)
> > +{
> > +     g_hash_table_destroy(assembly->assembly_table);
> =

> You should also be g_freeing the assembly structure itself.  In general, =
it is
> a very good idea to run valgrind --leak-check=3Dfull on the modified bina=
ry
> before submitting any patches upstream.  This helps to identify such issu=
es
> early.

Yes, I'll start using valgrind so I don't forget to free something.

> And did I mention unit tests? :)

And will add the unit tests to my todo list :)
|
> > +             if (status_report->status_report.st =3D=3D
> > +                                             SMS_ST_COMPLETED_RECEIVED=
) {
> > +                     /* mr belongs to this node */
> > +                     node->mrs[offset] ^=3D bit;
> > +                     *msg_id =3D node->ofono_msg_id;
> > +
> > +                     for (i =3D 0; i < 8; i++) {
> > +                             /* There are still pending mr(s). */
> > +                             if (node->mrs[i] !=3D 0)
> > +                                     return OFONO_HISTORY_SMS_STATUS_P=
ENDING;
> > +                     }
> > +             }
> > +             /* No more pending mrs for this node. Remove node from id=
_table
> > +              * and free it.
> > +              */
> > +             g_hash_table_iter_remove(&iter);
> > +             /* id_list empty, remove key and value from assembly_tabl=
e */
> > +             if (g_hash_table_size(id_table) =3D=3D 0)
> > +                     g_hash_table_remove(assembly->assembly_table,
> > +                             status_report->status_report.raddr.addres=
s);
> > +
> > +             return OFONO_HISTORY_SMS_STATUS_DELIVERED;
>
> You're marking this message as delivered even if a failure status report =
was
> sent.  Also, in the case of a failure, you're not providing the message i=
d.

Yes, this was like this because the non-delivered status report results were
identified by the  function caller in this version. But I agree that the fu=
nction logic
by itself is not right. And you're correct in that the if clause should sta=
rt after
the msg_id setting. Will correct these. I was in too much of a haste at the=
 end
of the day when I made these changes.

> Regards,
> -Denis

Br,
-Pasi



--===============5846872541649990024==--

