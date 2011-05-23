Content-Type: multipart/mixed; boundary="===============7447430508217482439=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Re: Could not able to detect ST Ericsson Modems
Date: Mon, 23 May 2011 09:49:05 +0530
Message-ID: <BANLkTimQH20K01uM=g_L8OBu+VG_Cvw8xw@mail.gmail.com>
In-Reply-To: <1305899346.2681.1.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7447430508217482439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

Thanks for your reply,

I connected via mini USB cable( used male female USB connector)

 To detect ST Ericsson  board , added few lines in
/etc/udev/rules.d/97-ofono.rules


ATTRS{idVendor}=3D=3D"0403", ATTRS{idProduct}=3D=3D"6010", ENV{OFONO_DRIVER=
}=3D"ste"

Here problem is, first of all Meego could not able to detect the idvendor
and id Product

In Meego i have USB related drivers support(Ft1000,usb-serial etc)

Thanks

Yuvaraj R

On Fri, May 20, 2011 at 7:19 PM, Marcel Holtmann <marcel@holtmann.org>wro=
te:

> Hi Yuvaraj,
>
> > I am connecting ST Ericsson modem with Nokia N900 device.
> >
> > N900 has Meego with CAIF protocol support. And i modified 97-ofono.rules
> > file to load ST Ericsson's modem
> >
> > But N900 could not able to detect the ST Ericsson modem. I verified via
> > dmesg and lsusb commands.
> >
> > Do i need to enable any modules in meego kernel?
>
> how did you attach the STE modem to your N900. And you might also need
> the STE init daemon to detect the modem.
>
> Personally I never had a STE modem, so I can't really help you here.
>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============7447430508217482439==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgPGJyPjxicj5UaGFua3MgZm9yIHlvdXIgcmVwbHksPGJyPjxicj5JIGNvbm5lY3RlZCB2aWEg
bWluaSBVU0IgY2FibGUoIHVzZWQgbWFsZSBmZW1hbGUgVVNCIGNvbm5lY3Rvcik8YnI+PGJyPqBU
byBkZXRlY3QgU1QgRXJpY3Nzb26gIGJvYXJkICwgYWRkZWQgZmV3IGxpbmVzIGluIC9ldGMvdWRl
di9ydWxlcy5kLzk3LW9mb25vLnJ1bGVzPGJyPjxicj6gIAoKCgk8bWV0YSBodHRwLWVxdWl2PSJD
T05URU5ULVRZUEUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+Cgk8dGl0bGU+
PC90aXRsZT4KCTxtZXRhIG5hbWU9IkdFTkVSQVRPUiIgY29udGVudD0iT3Blbk9mZmljZS5vcmcg
My4yICAoTGludXgpIj4KCTxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+Cgk8IS0tCgkJQHBhZ2UgeyBt
YXJnaW46IDJjbSB9CgkJUCB7IG1hcmdpbi1sZWZ0OiAyLjNjbTsgbWFyZ2luLXRvcDogMC40NmNt
OyBtYXJnaW4tYm90dG9tOiAwY20gfQoJLS0+PC9zdHlsZT48YnI+QVRUUlN7aWRWZW5kb3J9PT0m
cXVvdDswNDAzJnF1b3Q7LCBBVFRSU3tpZFByb2R1Y3R9PT0mcXVvdDs2MDEwJnF1b3Q7LApFTlZ7
T0ZPTk9fRFJJVkVSfT0mcXVvdDtzdGUmcXVvdDsKPGJyPjxicj5IZXJlIHByb2JsZW0gaXMsIGZp
cnN0IG9mIGFsbCBNZWVnbyBjb3VsZCBub3QgYWJsZSB0byBkZXRlY3QgdGhlIGlkdmVuZG9yIGFu
ZCBpZCBQcm9kdWN0PGJyPjxicj5JbiBNZWVnbyBpIGhhdmUgVVNCIHJlbGF0ZWQgZHJpdmVycyBz
dXBwb3J0KEZ0MTAwMCx1c2Itc2VyaWFsIGV0Yyk8YnI+PGJyPlRoYW5rczxicj48YnI+WXV2YXJh
aiBSPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+Ck9uIEZyaSwgTWF5IDIwLCAyMDEx
IGF0IDc6MTkgUE0sIE1hcmNlbCBIb2x0bWFubiA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9
Im1haWx0bzptYXJjZWxAaG9sdG1hbm4ub3JnIj5tYXJjZWxAaG9sdG1hbm4ub3JnPC9hPiZndDs8
L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQs
IDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KSGkgWXV2YXJhaiw8YnI+CjxkaXYgY2xh
c3M9ImltIj48YnI+CiZndDsgSSBhbSBjb25uZWN0aW5nIFNUIEVyaWNzc29uIG1vZGVtIHdpdGgg
Tm9raWEgTjkwMCBkZXZpY2UuPGJyPgomZ3Q7PGJyPgomZ3Q7IE45MDAgaGFzIE1lZWdvIHdpdGgg
Q0FJRiBwcm90b2NvbCBzdXBwb3J0LiBBbmQgaSBtb2RpZmllZCA5Ny1vZm9uby5ydWxlczxicj4K
Jmd0OyBmaWxlIHRvIGxvYWQgU1QgRXJpY3Nzb24mIzM5O3MgbW9kZW08YnI+CiZndDs8YnI+CiZn
dDsgQnV0IE45MDAgY291bGQgbm90IGFibGUgdG8gZGV0ZWN0IHRoZSBTVCBFcmljc3NvbiBtb2Rl
bS4gSSB2ZXJpZmllZCB2aWE8YnI+CiZndDsgZG1lc2cgYW5kIGxzdXNiIGNvbW1hbmRzLjxicj4K
Jmd0Ozxicj4KJmd0OyBEbyBpIG5lZWQgdG8gZW5hYmxlIGFueSBtb2R1bGVzIGluIG1lZWdvIGtl
cm5lbD88YnI+Cjxicj4KPC9kaXY+aG93IGRpZCB5b3UgYXR0YWNoIHRoZSBTVEUgbW9kZW0gdG8g
eW91ciBOOTAwLiBBbmQgeW91IG1pZ2h0IGFsc28gbmVlZDxicj4KdGhlIFNURSBpbml0IGRhZW1v
biB0byBkZXRlY3QgdGhlIG1vZGVtLjxicj4KPGJyPgpQZXJzb25hbGx5IEkgbmV2ZXIgaGFkIGEg
U1RFIG1vZGVtLCBzbyBJIGNhbiYjMzk7dCByZWFsbHkgaGVscCB5b3UgaGVyZS48YnI+Cjxicj4K
UmVnYXJkczxicj4KPGJyPgpNYXJjZWw8YnI+Cjxicj4KPGJyPgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8
YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8
YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvYmxv
Y2txdW90ZT48L2Rpdj48YnI+Cg==

--===============7447430508217482439==--

