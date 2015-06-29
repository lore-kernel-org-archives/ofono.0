Content-Type: multipart/mixed; boundary="===============8478321176481083872=="
MIME-Version: 1.0
From: Marko Sulejic <marko.sulejic@hale.at>
Subject: Re: HE910 + ofono: "Activating context failed with error: Unknown
 error type"
Date: Mon, 29 Jun 2015 15:33:12 +0200
Message-ID: <55914918.80109@hale.at>
In-Reply-To: <CAH4ZQwuimaHq1-FXu-NQCj5tGiuwEg1aSXQzPN_Q7bZ6bLRXzQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8478321176481083872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico!

Am 2015-06-29 um 14:59 schrieb Enrico Sau:
> Hi Marko,
> I had a similar problem with HE910 and I solved with the following =

> code line immediatly after line 99 in he910.c plugin:
>
> 99| g_hash_table_insert(options, "Baud", "115200");
> 100| *g_hash_table_insert(options, "Local", "on");*
>
> Let me know if it helps.
>
>
> Enrico
>

Thanks for the answer, but unfortunately it didn't help me.

I figured out that the *at_cgdcont_cb() *callback is not called on =

reconnect:

_The correct log_ (on startup):

Jun 29 15:16:38 mx31tt01 daemon.warn connmand[561]: Skipping disconnect =

of /he910_0/context15, network is connecting.
Jun 29 15:16:38 mx31tt01 daemon.debug ofonod[657]: =

gprs-context.c(240):at_gprs_activate_primary() cid 1
Jun 29 15:16:38 mx31tt01 daemon.info ofonod[657]: Modem: > =

AT+CGDCONT=3D1,"IP","web.one.at"\r
Jun 29 15:16:38 mx31tt01 daemon.info ofonod[657]: Modem: < =

AT+CGDCONT=3D1,"IP","web.one.at"\r
Jun 29 15:16:38 mx31tt01 daemon.info ofonod[657]: Modem: < \r\nOK\r\n
Jun 29 15:16:38 mx31tt01 daemon.debug ofonod[657]: =

gprs-context.c(200):*at_cgdcont_cb()* ok 1
Jun 29 15:16:38 mx31tt01 daemon.info ofonod[657]: Modem: > =

AT+CGDATA=3D"PPP",1\r
Jun 29 15:16:38 mx31tt01 daemon.info ofonod[657]: Modem: < =

AT+CGDATA=3D"PPP",1\r
Jun 29 15:16:38 mx31tt01 daemon.info ofonod[657]: Modem: < \r\nCONNECT\r\n
Jun 29 15:16:38 mx31tt01 daemon.debug ofonod[657]: =

gprs-context.c(176):*at_cgdata_cb()* ok 1
Jun 29 15:16:38 mx31tt01 daemon.debug ofonod[657]: =

gprs-context.c(141):setup_ppp()


_And the fail log _(on reconnect):

Jun 29 15:19:34 mx31tt01 daemon.debug ofonod[657]: =

gprs-context.c(240):at_gprs_activate_primary() cid 1
Jun 29 15:19:34 mx31tt01 daemon.info ofonod[657]: Modem: > =

AT+CGDCONT=3D1,"IP","web.one.at"\r
...

Jun 29 15:20:14 mx31tt01 daemon.err connmand[561]: Failed to change =

property: /he910_0/context15 org.ofono.ConnectionContext.Active: =

org.freedesktop.DBus.Error.NoReply Did not receive a reply. Possible =

causes include: the remote application did not send a reply, the mess
Jun 29 15:21:25 mx31tt01 daemon.warn connmand[561]: Skipping disconnect =

of /he910_0/context15, network is connecting.
Jun 29 15:21:25 mx31tt01 daemon.err connmand[561]: Failed to change =

property: /he910_0/context15 org.ofono.ConnectionContext.Active: =

org.ofono.Error.InProgress Operation already in progress


Any idea what could cause this?

Regards,
Marko

>
> 2015-06-29 13:16 GMT+02:00 Marko Sulejic <marko.sulejic@hale.at =

> <mailto:marko.sulejic@hale.at>>:
>
>
>     Am 2015-06-25 um 15:05 schrieb Marko Sulejic:
>
>         Hi again,
>
>         the problem seems to be in the
>         atmodem/gprs-context.c : gprs_activate_primary
>         function, where
>
>             if (g_at_chat_send(gcd->chat, buf, none_prefix,
>                         at_cgdcont_cb, gc, NULL) > 0)
>
>         is called after a reconnect, and then it fails.
>
>
>         It seems to work if I call
>
>             g_at_chat_send(gcd->chat, "AT&C0", none_prefix,
>                         NULL, NULL, NULL)
>
>         prior.
>
>         So this would mean that a disconnect or similar action sets
>         DCD to low,
>         and the chats are closed.
>
>         Does oFono anywhere in the code sets DCD explicitely to low or
>         is it maybe a bug?
>
>         My patch would look something like this (if it is an HE910
>         issue only):
>
>             if (gcd->vendor =3D=3D OFONO_VENDOR_TELIT)
>             {
>                 if(g_at_chat_send(gcd->chat, "AT&C0", none_prefix,
>                             NULL, NULL, NULL) <=3D 0)
>                     goto error;
>             }
>
>
>         Thanks,
>         Marko
>
>
>         Am 2015-06-25 um 11:15 schrieb Marko Sulejic:
>
>             Hi,
>
>             I need your help in using a Telit HE910 with ofono (and
>             eventually connman).
>             (I am using ofono 1.16 with HE910 firmware version
>             12.00.006; connman version is 1.29).
>
>             My problem is the following ...
>             on startup everything works fine and the ppp0 connection
>             is established,
>             but problems occur in the following case:
>
>             connmanctl> disconnect cellular_*_context15
>             Disconnected cellular_*_context15
>
>             connmanctl> connect cellular_*_context15
>             Error /net/connman/service/cellular_*_context15:
>             Input/output error
>
>
>             ofonod[5355]:
>             gprs-context.c(244):at_gprs_activate_primary() cid 1
>             ofonod[5355]: gprs.c(889):pri_activate_callback() 0x1a18c50
>             ofonod[5355]: gprs.c(893):pri_activate_callback()
>             Activating context failed with error: Unknown error type
>             connmand[3815]: Failed to change property:
>             /he910_0/context15 org.ofono.ConnectionContext.Active:
>             org.ofono.Error.Failed Operation failed
>
>
>             The same error happens if I am manually sending
>             connect/disconnect via dbus-send.
>
>             Only a hard ofono restart can establish the connection again.
>             This behavior happens all the time once a ppp0 disconnect
>             happened
>             (e.g. by removing the SIM; manual disconnect via dbus or
>             connmanctl).
>
>             A subquestion regarding connman:
>             Can connmand be configured in such a way that on every
>             connection
>             loss, ofono is triggered to reconnect to the Internet?
>
>             Thank you very muchin advance,
>             Marko
>             _______________________________________________
>             ofono mailing list
>             ofono(a)ofono.org <mailto:ofono@ofono.org>
>             https://lists.ofono.org/mailman/listinfo/ofono
>
>
>         _______________________________________________
>         ofono mailing list
>         ofono(a)ofono.org <mailto:ofono@ofono.org>
>         https://lists.ofono.org/mailman/listinfo/ofono
>
>
>
>     Hi,
>
>     ok, the above code doesn't seem to solve the problem.
>
>     Regards,
>
>     Marko
>
>
>
>
>
>     _______________________________________________
>     ofono mailing list
>     ofono(a)ofono.org <mailto:ofono@ofono.org>
>     https://lists.ofono.org/mailman/listinfo/ofono
>
>
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


--===============8478321176481083872==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4KICAgIEhpIEVucmljbyE8YnI+
CiAgICA8YnI+CiAgICBBbSAyMDE1LTA2LTI5IHVtIDE0OjU5IHNjaHJpZWIgRW5yaWNvIFNhdTo8
YnI+CiAgICA8YmxvY2txdW90ZQpjaXRlPSJtaWQ6Q0FINFpRd3VpbWFIcTEtRlh1LU5RQ2o1dEdp
dXdFZzFhU1hRelBOX1E3Ylo2YkxSWHpRQG1haWwuZ21haWwuY29tIgogICAgICB0eXBlPSJjaXRl
Ij4KICAgICAgPGRpdiBkaXI9Imx0ciI+CiAgICAgICAgPGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIKICAgICAgICAgIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPkhpIE1h
cmtvLDwvZGl2PgogICAgICAgIDxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiCiAgICAgICAgICBz
dHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5JIGhhZCBhIHNpbWlsYXIgcHJv
YmxlbQogICAgICAgICAgd2l0aCBIRTkxMCBhbmQgSSBzb2x2ZWQgd2l0aCB0aGUgZm9sbG93aW5n
IGNvZGUgbGluZQogICAgICAgICAgaW1tZWRpYXRseSBhZnRlcqBsaW5lIDk5IGluIGhlOTEwLmMg
cGx1Z2luOjwvZGl2PgogICAgICAgIDxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiCiAgICAgICAg
ICBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48YnI+CiAgICAgICAgPC9k
aXY+CiAgICAgICAgPGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIKICAgICAgICAgIHN0eWxlPSJm
b250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPjk5fAogICAgICAgICAgZ19oYXNoX3RhYmxl
X2luc2VydChvcHRpb25zLCAiQmF1ZCIsICIxMTUyMDAiKTs8L2Rpdj4KICAgICAgICA8ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IgogICAgICAgICAgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEs
c2Fucy1zZXJpZiI+MTAwfCA8Yj5nX2hhc2hfdGFibGVfaW5zZXJ0KG9wdGlvbnMsCiAgICAgICAg
ICAgICJMb2NhbCIsICJvbiIpOzwvYj48L2Rpdj4KICAgICAgICA8ZGl2IGNsYXNzPSJnbWFpbF9k
ZWZhdWx0IgogICAgICAgICAgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+
PGJyPgogICAgICAgIDwvZGl2PgogICAgICAgIDxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiCiAg
ICAgICAgICBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5MZXQgbWUga25v
dyBpZiBpdAogICAgICAgICAgaGVscHMuoDwvZGl2PgogICAgICA8L2Rpdj4KICAgICAgPGRpdiBj
bGFzcz0iZ21haWxfZXh0cmEiPjxiciBjbGVhcj0iYWxsIj4KICAgICAgICA8ZGl2PgogICAgICAg
ICAgPGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIj4KICAgICAgICAgICAgPGRpdj48YnI+CiAg
ICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICA8ZGl2PkVucmljbzwvZGl2PgogICAgICAgICAg
ICA8ZGl2Pjxicj4KICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICA8L2Rpdj4KICAgICAgICA8
L2Rpdj4KICAgICAgPC9kaXY+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAgICBUaGFua3Mg
Zm9yIHRoZSBhbnN3ZXIsIGJ1dCB1bmZvcnR1bmF0ZWx5IGl0IGRpZG4ndCBoZWxwIG1lLjxicj4K
ICAgIDxicj4KICAgIEkgZmlndXJlZCBvdXQgdGhhdCB0aGUgPGI+YXRfY2dkY29udF9jYigpIDwv
Yj5jYWxsYmFjayBpcyBub3QKICAgIGNhbGxlZCBvbiByZWNvbm5lY3Q6PGJyPgogICAgPGJyPgog
ICAgPHU+VGhlIGNvcnJlY3QgbG9nPC91PiAob24gc3RhcnR1cCk6PGJyPgogICAgPGJyPgogICAg
SnVuIDI5IDE1OjE2OjM4IG14MzF0dDAxIGRhZW1vbi53YXJuIGNvbm5tYW5kWzU2MV06IFNraXBw
aW5nCiAgICBkaXNjb25uZWN0IG9mIC9oZTkxMF8wL2NvbnRleHQxNSwgbmV0d29yayBpcyBjb25u
ZWN0aW5nLjxicj4KICAgIEp1biAyOSAxNToxNjozOCBteDMxdHQwMSBkYWVtb24uZGVidWcgb2Zv
bm9kWzY1N106CiAgICBncHJzLWNvbnRleHQuYygyNDApOmF0X2dwcnNfYWN0aXZhdGVfcHJpbWFy
eSgpIGNpZCAxPGJyPgogICAgSnVuIDI5IDE1OjE2OjM4IG14MzF0dDAxIGRhZW1vbi5pbmZvIG9m
b25vZFs2NTddOiBNb2RlbTogJmd0OwogICAgQVQrQ0dEQ09OVD0xLCJJUCIsIndlYi5vbmUuYXQi
XHI8YnI+CiAgICBKdW4gMjkgMTU6MTY6MzggbXgzMXR0MDEgZGFlbW9uLmluZm8gb2Zvbm9kWzY1
N106IE1vZGVtOiAmbHQ7CiAgICBBVCtDR0RDT05UPTEsIklQIiwid2ViLm9uZS5hdCJccjxicj4K
ICAgIEp1biAyOSAxNToxNjozOCBteDMxdHQwMSBkYWVtb24uaW5mbyBvZm9ub2RbNjU3XTogTW9k
ZW06ICZsdDsKICAgIFxyXG5PS1xyXG48YnI+CiAgICBKdW4gMjkgMTU6MTY6MzggbXgzMXR0MDEg
ZGFlbW9uLmRlYnVnIG9mb25vZFs2NTddOgogICAgZ3Bycy1jb250ZXh0LmMoMjAwKTo8Yj5hdF9j
Z2Rjb250X2NiKCk8L2I+IG9rIDE8YnI+CiAgICBKdW4gMjkgMTU6MTY6MzggbXgzMXR0MDEgZGFl
bW9uLmluZm8gb2Zvbm9kWzY1N106IE1vZGVtOiAmZ3Q7CiAgICBBVCtDR0RBVEE9IlBQUCIsMVxy
PGJyPgogICAgSnVuIDI5IDE1OjE2OjM4IG14MzF0dDAxIGRhZW1vbi5pbmZvIG9mb25vZFs2NTdd
OiBNb2RlbTogJmx0OwogICAgQVQrQ0dEQVRBPSJQUFAiLDFccjxicj4KICAgIEp1biAyOSAxNTox
NjozOCBteDMxdHQwMSBkYWVtb24uaW5mbyBvZm9ub2RbNjU3XTogTW9kZW06ICZsdDsKICAgIFxy
XG5DT05ORUNUXHJcbjxicj4KICAgIEp1biAyOSAxNToxNjozOCBteDMxdHQwMSBkYWVtb24uZGVi
dWcgb2Zvbm9kWzY1N106CiAgICBncHJzLWNvbnRleHQuYygxNzYpOjxiPmF0X2NnZGF0YV9jYigp
PC9iPiBvayAxPGJyPgogICAgSnVuIDI5IDE1OjE2OjM4IG14MzF0dDAxIGRhZW1vbi5kZWJ1ZyBv
Zm9ub2RbNjU3XToKICAgIGdwcnMtY29udGV4dC5jKDE0MSk6c2V0dXBfcHBwKCk8YnI+CiAgICA8
YnI+CiAgICA8YnI+CiAgICA8dT5BbmQgdGhlIGZhaWwgbG9nIDwvdT4ob24gcmVjb25uZWN0KTo8
YnI+CiAgICA8YnI+CiAgICBKdW4gMjkgMTU6MTk6MzQgbXgzMXR0MDEgZGFlbW9uLmRlYnVnIG9m
b25vZFs2NTddOgogICAgZ3Bycy1jb250ZXh0LmMoMjQwKTphdF9ncHJzX2FjdGl2YXRlX3ByaW1h
cnkoKSBjaWQgMTxicj4KICAgIEp1biAyOSAxNToxOTozNCBteDMxdHQwMSBkYWVtb24uaW5mbyBv
Zm9ub2RbNjU3XTogTW9kZW06ICZndDsKICAgIEFUK0NHRENPTlQ9MSwiSVAiLCJ3ZWIub25lLmF0
IlxyPGJyPgogICAgLi4uPGJyPgogICAgPGJyPgogICAgSnVuIDI5IDE1OjIwOjE0IG14MzF0dDAx
IGRhZW1vbi5lcnIgY29ubm1hbmRbNTYxXTogRmFpbGVkIHRvIGNoYW5nZQogICAgcHJvcGVydHk6
IC9oZTkxMF8wL2NvbnRleHQxNSBvcmcub2Zvbm8uQ29ubmVjdGlvbkNvbnRleHQuQWN0aXZlOgog
ICAgb3JnLmZyZWVkZXNrdG9wLkRCdXMuRXJyb3IuTm9SZXBseSBEaWQgbm90IHJlY2VpdmUgYSBy
ZXBseS4gUG9zc2libGUKICAgIGNhdXNlcyBpbmNsdWRlOiB0aGUgcmVtb3RlIGFwcGxpY2F0aW9u
IGRpZCBub3Qgc2VuZCBhIHJlcGx5LCB0aGUKICAgIG1lc3M8YnI+CiAgICBKdW4gMjkgMTU6MjE6
MjUgbXgzMXR0MDEgZGFlbW9uLndhcm4gY29ubm1hbmRbNTYxXTogU2tpcHBpbmcKICAgIGRpc2Nv
bm5lY3Qgb2YgL2hlOTEwXzAvY29udGV4dDE1LCBuZXR3b3JrIGlzIGNvbm5lY3RpbmcuPGJyPgog
ICAgSnVuIDI5IDE1OjIxOjI1IG14MzF0dDAxIGRhZW1vbi5lcnIgY29ubm1hbmRbNTYxXTogRmFp
bGVkIHRvIGNoYW5nZQogICAgcHJvcGVydHk6IC9oZTkxMF8wL2NvbnRleHQxNSBvcmcub2Zvbm8u
Q29ubmVjdGlvbkNvbnRleHQuQWN0aXZlOgogICAgb3JnLm9mb25vLkVycm9yLkluUHJvZ3Jlc3Mg
T3BlcmF0aW9uIGFscmVhZHkgaW4gcHJvZ3Jlc3M8YnI+CiAgICA8YnI+CiAgICA8YnI+CiAgICBB
bnkgaWRlYSB3aGF0IGNvdWxkIGNhdXNlIHRoaXM/PGJyPgogICAgPGJyPgogICAgUmVnYXJkcyw8
YnI+CiAgICBNYXJrbzxicj4KICAgIDxicj4KICAgIDxibG9ja3F1b3RlCmNpdGU9Im1pZDpDQUg0
WlF3dWltYUhxMS1GWHUtTlFDajV0R2l1d0VnMWFTWFF6UE5fUTdiWjZiTFJYelFAbWFpbC5nbWFp
bC5jb20iCiAgICAgIHR5cGU9ImNpdGUiPgogICAgICA8ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+
CiAgICAgICAgPGJyPgogICAgICAgIDxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE1LTA2LTI5
IDEzOjE2IEdNVCswMjowMCBNYXJrbwogICAgICAgICAgU3VsZWppYyA8c3BhbiBkaXI9Imx0ciI+
Jmx0OzxhIG1vei1kby1ub3Qtc2VuZD0idHJ1ZSIKICAgICAgICAgICAgICBocmVmPSJtYWlsdG86
bWFya28uc3VsZWppY0BoYWxlLmF0IiB0YXJnZXQ9Il9ibGFuayI+bWFya28uc3VsZWppY0BoYWxl
LmF0PC9hPiZndDs8L3NwYW4+Ojxicj4KICAgICAgICAgIDxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMAogICAgICAgICAgICAuOGV4O2JvcmRlci1sZWZ0
OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgogICAgICAgICAgICA8ZGl2IGNsYXNz
PSJIT0VuWmIiPgogICAgICAgICAgICAgIDxkaXYgY2xhc3M9Img1Ij48YnI+CiAgICAgICAgICAg
ICAgICBBbSAyMDE1LTA2LTI1IHVtIDE1OjA1IHNjaHJpZWIgTWFya28gU3VsZWppYzo8YnI+CiAg
ICAgICAgICAgICAgICA8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAKICAgICAgICAgICAgICAgICAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KICAgICAgICAgICAgICAgICAgSGkgYWdhaW4sPGJyPgogICAg
ICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgICAgIHRoZSBwcm9ibGVtIHNlZW1zIHRv
IGJlIGluIHRoZTxicj4KICAgICAgICAgICAgICAgICAgYXRtb2RlbS9ncHJzLWNvbnRleHQuYyA6
IGdwcnNfYWN0aXZhdGVfcHJpbWFyeTxicj4KICAgICAgICAgICAgICAgICAgZnVuY3Rpb24sIHdo
ZXJlPGJyPgogICAgICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgICAgIKAgoCBpZiAo
Z19hdF9jaGF0X3NlbmQoZ2NkLSZndDtjaGF0LCBidWYsIG5vbmVfcHJlZml4LDxicj4KICAgICAg
ICAgICAgICAgICAgoCCgIKAgoCCgIKAgoCCgIGF0X2NnZGNvbnRfY2IsIGdjLCBOVUxMKSAmZ3Q7
IDApPGJyPgogICAgICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgICAgIGlzIGNhbGxl
ZCBhZnRlciBhIHJlY29ubmVjdCwgYW5kIHRoZW4gaXQgZmFpbHMuPGJyPgogICAgICAgICAgICAg
ICAgICA8YnI+CiAgICAgICAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgICAgICAgSXQgc2Vl
bXMgdG8gd29yayBpZiBJIGNhbGw8YnI+CiAgICAgICAgICAgICAgICAgIDxicj4KICAgICAgICAg
ICAgICAgICAgoCCgIGdfYXRfY2hhdF9zZW5kKGdjZC0mZ3Q7Y2hhdCwgIkFUJmFtcDtDMCIsCiAg
ICAgICAgICAgICAgICAgIG5vbmVfcHJlZml4LDxicj4KICAgICAgICAgICAgICAgICAgoCCgIKAg
oCCgIKAgoCCgIE5VTEwsIE5VTEwsIE5VTEwpPGJyPgogICAgICAgICAgICAgICAgICA8YnI+CiAg
ICAgICAgICAgICAgICAgIHByaW9yLjxicj4KICAgICAgICAgICAgICAgICAgPGJyPgogICAgICAg
ICAgICAgICAgICBTbyB0aGlzIHdvdWxkIG1lYW4gdGhhdCBhIGRpc2Nvbm5lY3Qgb3Igc2ltaWxh
ciBhY3Rpb24KICAgICAgICAgICAgICAgICAgc2V0cyBEQ0QgdG8gbG93LDxicj4KICAgICAgICAg
ICAgICAgICAgYW5kIHRoZSBjaGF0cyBhcmUgY2xvc2VkLjxicj4KICAgICAgICAgICAgICAgICAg
PGJyPgogICAgICAgICAgICAgICAgICBEb2VzIG9Gb25vIGFueXdoZXJlIGluIHRoZSBjb2RlIHNl
dHMgRENEIGV4cGxpY2l0ZWx5CiAgICAgICAgICAgICAgICAgIHRvIGxvdyBvciBpcyBpdCBtYXli
ZSBhIGJ1Zz88YnI+CiAgICAgICAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgICAgICAgTXkg
cGF0Y2ggd291bGQgbG9vayBzb21ldGhpbmcgbGlrZSB0aGlzIChpZiBpdCBpcyBhbgogICAgICAg
ICAgICAgICAgICBIRTkxMCBpc3N1ZSBvbmx5KTo8YnI+CiAgICAgICAgICAgICAgICAgIDxicj4K
ICAgICAgICAgICAgICAgICAgoCCgIGlmIChnY2QtJmd0O3ZlbmRvciA9PSBPRk9OT19WRU5ET1Jf
VEVMSVQpPGJyPgogICAgICAgICAgICAgICAgICCgIKAgezxicj4KICAgICAgICAgICAgICAgICAg
oCCgIKAgoCBpZihnX2F0X2NoYXRfc2VuZChnY2QtJmd0O2NoYXQsICJBVCZhbXA7QzAiLAogICAg
ICAgICAgICAgICAgICBub25lX3ByZWZpeCw8YnI+CiAgICAgICAgICAgICAgICAgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgTlVMTCwgTlVMTCwgTlVMTCkgJmx0Oz0gMCk8YnI+CiAgICAgICAgICAgICAg
ICAgIKAgoCCgIKAgoCCgIGdvdG8gZXJyb3I7PGJyPgogICAgICAgICAgICAgICAgICCgIKAgfTxi
cj4KICAgICAgICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgICAgICA8YnI+CiAgICAgICAg
ICAgICAgICAgIFRoYW5rcyw8YnI+CiAgICAgICAgICAgICAgICAgIE1hcmtvPGJyPgogICAgICAg
ICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgICAgICAg
QW0gMjAxNS0wNi0yNSB1bSAxMToxNSBzY2hyaWViIE1hcmtvIFN1bGVqaWM6PGJyPgogICAgICAg
ICAgICAgICAgICA8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAKICAgICAgICAgICAgICAgICAgICAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPgogICAgICAgICAgICAgICAgICAgIEhpLDxicj4KICAgICAgICAg
ICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgICAgICAgSSBuZWVkIHlvdXIgaGVscCBpbiB1
c2luZyBhIFRlbGl0IEhFOTEwIHdpdGggb2Zvbm8KICAgICAgICAgICAgICAgICAgICAoYW5kIGV2
ZW50dWFsbHkgY29ubm1hbikuPGJyPgogICAgICAgICAgICAgICAgICAgIChJIGFtIHVzaW5nIG9m
b25vIDEuMTYgd2l0aCBIRTkxMCBmaXJtd2FyZSB2ZXJzaW9uCiAgICAgICAgICAgICAgICAgICAg
MTIuMDAuMDA2OyBjb25ubWFuIHZlcnNpb24gaXMgMS4yOSkuPGJyPgogICAgICAgICAgICAgICAg
ICAgIDxicj4KICAgICAgICAgICAgICAgICAgICBNeSBwcm9ibGVtIGlzIHRoZSBmb2xsb3dpbmcg
Li4uPGJyPgogICAgICAgICAgICAgICAgICAgIG9uIHN0YXJ0dXAgZXZlcnl0aGluZyB3b3JrcyBm
aW5lIGFuZCB0aGUgcHBwMAogICAgICAgICAgICAgICAgICAgIGNvbm5lY3Rpb24gaXMgZXN0YWJs
aXNoZWQsPGJyPgogICAgICAgICAgICAgICAgICAgIGJ1dCBwcm9ibGVtcyBvY2N1ciBpbiB0aGUg
Zm9sbG93aW5nIGNhc2U6PGJyPgogICAgICAgICAgICAgICAgICAgIDxicj4KICAgICAgICAgICAg
ICAgICAgICBjb25ubWFuY3RsJmd0OyBkaXNjb25uZWN0IGNlbGx1bGFyXypfY29udGV4dDE1PGJy
PgogICAgICAgICAgICAgICAgICAgIERpc2Nvbm5lY3RlZCBjZWxsdWxhcl8qX2NvbnRleHQxNTxi
cj4KICAgICAgICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgICAgICAgY29ubm1hbmN0
bCZndDsgY29ubmVjdCBjZWxsdWxhcl8qX2NvbnRleHQxNTxicj4KICAgICAgICAgICAgICAgICAg
ICBFcnJvciAvbmV0L2Nvbm5tYW4vc2VydmljZS9jZWxsdWxhcl8qX2NvbnRleHQxNToKICAgICAg
ICAgICAgICAgICAgICBJbnB1dC9vdXRwdXQgZXJyb3I8YnI+CiAgICAgICAgICAgICAgICAgICAg
PGJyPgogICAgICAgICAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgICAgICAgICBvZm9ub2Rb
NTM1NV06CiAgICAgICAgICAgICAgICAgICAgZ3Bycy1jb250ZXh0LmMoMjQ0KTphdF9ncHJzX2Fj
dGl2YXRlX3ByaW1hcnkoKSBjaWQgMTxicj4KICAgICAgICAgICAgICAgICAgICBvZm9ub2RbNTM1
NV06IGdwcnMuYyg4ODkpOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpCiAgICAgICAgICAgICAgICAg
ICAgMHgxYTE4YzUwPGJyPgogICAgICAgICAgICAgICAgICAgIG9mb25vZFs1MzU1XTogZ3Bycy5j
KDg5Myk6cHJpX2FjdGl2YXRlX2NhbGxiYWNrKCkKICAgICAgICAgICAgICAgICAgICBBY3RpdmF0
aW5nIGNvbnRleHQgZmFpbGVkIHdpdGggZXJyb3I6IFVua25vd24gZXJyb3IKICAgICAgICAgICAg
ICAgICAgICB0eXBlPGJyPgogICAgICAgICAgICAgICAgICAgIGNvbm5tYW5kWzM4MTVdOiBGYWls
ZWQgdG8gY2hhbmdlIHByb3BlcnR5OgogICAgICAgICAgICAgICAgICAgIC9oZTkxMF8wL2NvbnRl
eHQxNQogICAgICAgICAgICAgICAgICAgIG9yZy5vZm9uby5Db25uZWN0aW9uQ29udGV4dC5BY3Rp
dmU6CiAgICAgICAgICAgICAgICAgICAgb3JnLm9mb25vLkVycm9yLkZhaWxlZCBPcGVyYXRpb24g
ZmFpbGVkPGJyPgogICAgICAgICAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgICAgICAgICA8
YnI+CiAgICAgICAgICAgICAgICAgICAgVGhlIHNhbWUgZXJyb3IgaGFwcGVucyBpZiBJIGFtIG1h
bnVhbGx5IHNlbmRpbmcKICAgICAgICAgICAgICAgICAgICBjb25uZWN0L2Rpc2Nvbm5lY3Qgdmlh
IGRidXMtc2VuZC48YnI+CiAgICAgICAgICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgICAg
ICAgIE9ubHkgYSBoYXJkIG9mb25vIHJlc3RhcnQgY2FuIGVzdGFibGlzaCB0aGUKICAgICAgICAg
ICAgICAgICAgICBjb25uZWN0aW9uIGFnYWluLjxicj4KICAgICAgICAgICAgICAgICAgICBUaGlz
IGJlaGF2aW9yIGhhcHBlbnMgYWxsIHRoZSB0aW1lIG9uY2UgYSBwcHAwCiAgICAgICAgICAgICAg
ICAgICAgZGlzY29ubmVjdCBoYXBwZW5lZDxicj4KICAgICAgICAgICAgICAgICAgICAoZS5nLiBi
eSByZW1vdmluZyB0aGUgU0lNOyBtYW51YWwgZGlzY29ubmVjdCB2aWEKICAgICAgICAgICAgICAg
ICAgICBkYnVzIG9yIGNvbm5tYW5jdGwpLjxicj4KICAgICAgICAgICAgICAgICAgICA8YnI+CiAg
ICAgICAgICAgICAgICAgICAgQSBzdWJxdWVzdGlvbiByZWdhcmRpbmcgY29ubm1hbjo8YnI+CiAg
ICAgICAgICAgICAgICAgICAgQ2FuIGNvbm5tYW5kIGJlIGNvbmZpZ3VyZWQgaW4gc3VjaCBhIHdh
eSB0aGF0IG9uCiAgICAgICAgICAgICAgICAgICAgZXZlcnkgY29ubmVjdGlvbjxicj4KICAgICAg
ICAgICAgICAgICAgICBsb3NzLCBvZm9ubyBpcyB0cmlnZ2VyZWQgdG8gcmVjb25uZWN0IHRvIHRo
ZQogICAgICAgICAgICAgICAgICAgIEludGVybmV0Pzxicj4KICAgICAgICAgICAgICAgICAgICA8
YnI+CiAgICAgICAgICAgICAgICAgICAgVGhhbmsgeW91IHZlcnkgbXVjaGluIGFkdmFuY2UsPGJy
PgogICAgICAgICAgICAgICAgICAgIE1hcmtvPGJyPgogICAgICAgICAgICAgICAgICAgIF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgogICAgICAgICAg
ICAgICAgICAgIG9mb25vIG1haWxpbmcgbGlzdDxicj4KICAgICAgICAgICAgICAgICAgICA8YSBt
b3otZG8tbm90LXNlbmQ9InRydWUiCiAgICAgICAgICAgICAgICAgICAgICBocmVmPSJtYWlsdG86
b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4K
ICAgICAgICAgICAgICAgICAgICA8YSBtb3otZG8tbm90LXNlbmQ9InRydWUiCiAgICAgICAgICAg
ICAgICAgICAgICBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L29mb25vIgogICAgICAgICAgICAgICAgICAgICAgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubzwvYT48
YnI+CiAgICAgICAgICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgICAgICAgPGJy
PgogICAgICAgICAgICAgICAgICBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXzxicj4KICAgICAgICAgICAgICAgICAgb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgog
ICAgICAgICAgICAgICAgICA8YSBtb3otZG8tbm90LXNlbmQ9InRydWUiCiAgICAgICAgICAgICAg
ICAgICAgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25v
QG9mb25vLm9yZzwvYT48YnI+CiAgICAgICAgICAgICAgICAgIDxhIG1vei1kby1ub3Qtc2VuZD0i
dHJ1ZSIKICAgICAgICAgICAgICAgICAgICBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL29mb25vIgogICAgICAgICAgICAgICAgICAgIHJlbD0ibm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGlu
Zm8vb2Zvbm88L2E+PGJyPgogICAgICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAg
ICAgICAgPGJyPgogICAgICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgIDwvZGl2PgogICAg
ICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgSGksPGJyPgogICAgICAgICAgICA8YnI+CiAgICAg
ICAgICAgIG9rLCB0aGUgYWJvdmUgY29kZSBkb2Vzbid0IHNlZW0gdG8gc29sdmUgdGhlIHByb2Js
ZW0uPGJyPgogICAgICAgICAgICA8YnI+CiAgICAgICAgICAgIFJlZ2FyZHMsCiAgICAgICAgICAg
IDxkaXYgY2xhc3M9IkhPRW5aYiI+CiAgICAgICAgICAgICAgPGRpdiBjbGFzcz0iaDUiPjxicj4K
ICAgICAgICAgICAgICAgIE1hcmtvPGJyPgogICAgICAgICAgICAgICAgPGJyPgogICAgICAgICAg
ICAgICAgPGJyPgogICAgICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgICAgPGJyPgogICAg
ICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgICAgX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX188YnI+CiAgICAgICAgICAgICAgICBvZm9ubyBtYWlsaW5n
IGxpc3Q8YnI+CiAgICAgICAgICAgICAgICA8YSBtb3otZG8tbm90LXNlbmQ9InRydWUiIGhyZWY9
Im1haWx0bzpvZm9ub0BvZm9uby5vcmciCiAgICAgICAgICAgICAgICAgIHRhcmdldD0iX2JsYW5r
Ij5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgogICAgICAgICAgICAgICAgPGEgbW96LWRvLW5vdC1z
ZW5kPSJ0cnVlIgogICAgICAgICAgICAgICAgICBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIgogICAgICAgICAgICAgICAgICByZWw9Im5vcmVmZXJy
ZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL29mb25vPC9hPjxicj4KICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgPC9kaXY+
CiAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgPC9kaXY+CiAgICAgICAgPGJyPgogICAg
ICA8L2Rpdj4KICAgICAgPGJyPgogICAgICA8ZmllbGRzZXQgY2xhc3M9Im1pbWVBdHRhY2htZW50
SGVhZGVyIj48L2ZpZWxkc2V0PgogICAgICA8YnI+CiAgICAgIDxwcmUgd3JhcD0iIj5fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpvZm9ubyBtYWlsaW5nIGxp
c3QKPGEgY2xhc3M9Im1vei10eHQtbGluay1hYmJyZXZpYXRlZCIgaHJlZj0ibWFpbHRvOm9mb25v
QG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPgo8YSBjbGFzcz0ibW96LXR4dC1saW5rLWZy
ZWV0ZXh0IiBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29m
b25vIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPgo8
L3ByZT4KICAgIDwvYmxvY2txdW90ZT4KICAgIDxicj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============8478321176481083872==--

