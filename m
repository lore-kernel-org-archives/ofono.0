Content-Type: multipart/mixed; boundary="===============1731474891977193623=="
MIME-Version: 1.0
From: Jesper Larsen <jesper.larsen@ixonos.com>
Subject: Re: SIMCOM support
Date: Fri, 19 Jul 2013 15:55:54 +0200
Message-ID: <CAAZAA2FXw9+CAoS3Lo2rgqQ0Rg_LjvOU1eYJ9DPtmbecXSCNOg@mail.gmail.com>
In-Reply-To: <51E94019.7060604@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1731474891977193623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2013 at 3:33 PM, Viallard Anthony <
viallard@syscom-instruments.com> wrote:

> Hello folks,
>
> I cleaned my work on the SIMCOM plugin according to Denis' suggestions and
> add some new quirks. The patches will follow this mail.
>
> Moreover, I have two new questions:
>
>  - In my patches, I had to add a function in src/network.c to be able to
> report a new network technology. I was surprised that the function didn't
> exist. Maybe there are an other mecanism which I didn't see to change the
> network technology and send the dbus signal ?
>  - I see in mail sent by Jesper Larsen a patch about configuration of the
> serial port. The patch adds the option "Read" to "on". I didn't understand
> the behaviour of this option. What do this option make ?
>

It sets the CREAD flag in the termios structure applied to the tty (
http://linux.die.net/man/3/termios). The man page merely says that what it
does is "Enable receiver". Without it I didn't get any reply from the
module to AT commands.


>
> Have a good holidays,
>
> Regards,
> Anthony V.
>
> --
> ------------------------------**-----------
> Viallard Anthony    (+41 024 455 24 82)
> [ Embedded System | Software Designer ]
> ------------------------------**-----------
>   Syscom Instruments SA
>   Rue de l'industrie 21
>   1450     Sainte-Croix
> ------------------------------**-----------
> ______________________________**_________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/**mailman/listinfo/ofono<https://lists.ofono.org/=
mailman/listinfo/ofono>
>

--===============1731474891977193623==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBGcmksIEp1bCAxOSwgMjAxMyBhdCAzOjMzIFBNLCBWaWFs
bGFyZCBBbnRob255IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOnZpYWxsYXJk
QHN5c2NvbS1pbnN0cnVtZW50cy5jb20iIHRhcmdldD0iX2JsYW5rIj52aWFsbGFyZEBzeXNjb20t
aW5zdHJ1bWVudHMuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1s
ZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1s
ZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPkhlbGxvIGZvbGtzLDxicj4KPGJyPgpJ
IGNsZWFuZWQgbXkgd29yayBvbiB0aGUgU0lNQ09NIHBsdWdpbiBhY2NvcmRpbmcgdG8gRGVuaXMm
IzM5OyBzdWdnZXN0aW9ucyBhbmQgYWRkIHNvbWUgbmV3IHF1aXJrcy4gVGhlIHBhdGNoZXMgd2ls
bCBmb2xsb3cgdGhpcyBtYWlsLjxicj4KPGJyPgpNb3Jlb3ZlciwgSSBoYXZlIHR3byBuZXcgcXVl
c3Rpb25zOjxicj4KPGJyPgqgLSBJbiBteSBwYXRjaGVzLCBJIGhhZCB0byBhZGQgYSBmdW5jdGlv
biBpbiBzcmMvbmV0d29yay5jIHRvIGJlIGFibGUgdG8gcmVwb3J0IGEgbmV3IG5ldHdvcmsgdGVj
aG5vbG9neS4gSSB3YXMgc3VycHJpc2VkIHRoYXQgdGhlIGZ1bmN0aW9uIGRpZG4mIzM5O3QgZXhp
c3QuIE1heWJlIHRoZXJlIGFyZSBhbiBvdGhlciBtZWNhbmlzbSB3aGljaCBJIGRpZG4mIzM5O3Qg
c2VlIHRvIGNoYW5nZSB0aGUgbmV0d29yayB0ZWNobm9sb2d5IGFuZCBzZW5kIHRoZSBkYnVzIHNp
Z25hbCA/PGJyPgoKoC0gSSBzZWUgaW4gbWFpbCBzZW50IGJ5IEplc3BlciBMYXJzZW4gYSBwYXRj
aCBhYm91dCBjb25maWd1cmF0aW9uIG9mIHRoZSBzZXJpYWwgcG9ydC4gVGhlIHBhdGNoIGFkZHMg
dGhlIG9wdGlvbiAmcXVvdDtSZWFkJnF1b3Q7IHRvICZxdW90O29uJnF1b3Q7LiBJIGRpZG4mIzM5
O3QgdW5kZXJzdGFuZCB0aGUgYmVoYXZpb3VyIG9mIHRoaXMgb3B0aW9uLiBXaGF0IGRvIHRoaXMg
b3B0aW9uIG1ha2UgPzxicj4KPC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SXQgc2V0
cyB0aGUgQ1JFQUQgZmxhZyBpbiB0aGUgdGVybWlvcyBzdHJ1Y3R1cmUgYXBwbGllZCB0byB0aGUg
dHR5ICg8YSBocmVmPSJodHRwOi8vbGludXguZGllLm5ldC9tYW4vMy90ZXJtaW9zIj5odHRwOi8v
bGludXguZGllLm5ldC9tYW4vMy90ZXJtaW9zPC9hPikuIFRoZSBtYW4gcGFnZSBtZXJlbHkgc2F5
cyB0aGF0IHdoYXQgaXQgZG9lcyBpcyAmcXVvdDtFbmFibGUgcmVjZWl2ZXImcXVvdDsuIFdpdGhv
dXQgaXQgSSBkaWRuJiMzOTt0IGdldCBhbnkgcmVwbHkgZnJvbSB0aGUgbW9kdWxlIHRvIEFUIGNv
bW1hbmRzLjwvZGl2Pgo8ZGl2PqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2Jv
cmRlci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQ7
cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KSGF2ZSBhIGdvb2QgaG9saWRheXMsPGJyPgo8YnI+ClJl
Z2FyZHMsPGJyPgpBbnRob255IFYuPGJyPgo8YnI+Ci0tIDxicj4KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPHU+PC91Pi0tLS0tLS0tLS0tPGJyPgpWaWFsbGFyZCBBbnRob255IKAgoDxh
IGhyZWY9InRlbDolMjglMkI0MSUyMDAyNCUyMDQ1NSUyMDI0JTIwODIiIHZhbHVlPSIrNDEyNDQ1
NTI0ODIiIHRhcmdldD0iX2JsYW5rIj4oKzQxIDAyNCA0NTUgMjQgODI8L2E+KTxicj4KWyBFbWJl
ZGRlZCBTeXN0ZW0gfCBTb2Z0d2FyZSBEZXNpZ25lciBdPGJyPgotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08dT48L3U+LS0tLS0tLS0tLS08YnI+CqAgU3lzY29tIEluc3RydW1lbnRzIFNB
PGJyPgqgIFJ1ZSBkZSBsJiMzOTtpbmR1c3RyaWUgMjE8YnI+CqAgMTQ1MCCgIKAgU2FpbnRlLUNy
b2l4PGJyPgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08dT48L3U+LS0tLS0tLS0tLS08
YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzx1PjwvdT5fX19fX19fX19fX19fX19f
Xzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8u
b3JnIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0
cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubyIgdGFyZ2V0PSJfYmxh
bmsiPmh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnLzx1PjwvdT5tYWlsbWFuL2xpc3RpbmZvL29mb25v
PC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============1731474891977193623==--

