Content-Type: multipart/mixed; boundary="===============1108901924795112333=="
MIME-Version: 1.0
From: Sergei Golubtsov <s.e.golubtsov@gmail.com>
Subject: Re: oFono Version 1.31 ofonod crash
Date: Sun, 22 Aug 2021 13:19:12 +0200
Message-ID: <CAFiQ677d90DJCM6m+RgAJ-AieqpoBBY+soHXN-rH_bVP7Vgf6g@mail.gmail.com>
In-Reply-To: <CAA=hcWQAWZyiSTQ3r8DiTK2DFuJZZ7hDasAuggfR9shqwz2ioQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1108901924795112333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi jupiter,

Please try to update ofono to the latest release. Seems to be a library
incompatibility issue or something like that.

Yours sincerely,
Sergei Golubtsov.


On Sat, Aug 21, 2021 at 4:09 AM Jupiter <jupiter.hce@gmail.com> wrote:

> Hi,
>
> I build ofono v1.31 from git://git.yoctoproject.org/poky branch hardknott,
>
> $ cat meta/recipes-connectivity/ofono/ofono_1.31.bb
>
> SUMMARY =3D "open source telephony"
> DESCRIPTION =3D "oFono is a stack for mobile telephony devices on Linux.
> oFono supports speaking to telephony devices through specific drivers,
> or with generic AT commands."
> HOMEPAGE =3D "http://www.ofono.org"
> BUGTRACKER =3D "https://01.org/jira/browse/OF"
> LICENSE =3D "GPLv2"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Deb723b61539feef013de476e68b5c5=
0a \
>
>
> file://src/ofono.h;beginline=3D1;endline=3D20;md5=3D3ce17d5978ef3445def26=
5b98899c2ee"
> DEPENDS =3D "dbus glib-2.0 udev mobile-broadband-provider-info ell"
>
> SRC_URI =3D "\
>     ${KERNELORG_MIRROR}/linux/network/${BPN}/${BP}.tar.xz \
>     file://ofono \
>     file://0001-mbim-add-an-optional-TEMP_FAILURE_RETRY-macro-copy.patch \
> "
> SRC_URI[md5sum] =3D "1c26340e3c6ed132cc812595081bb3dc"
> SRC_URI[sha256sum] =3D
> "a15c5d28096c10eb30e47a68b6dc2e7c4a5a99d7f4cfedf0b69624f33d859e9b"
>
> inherit autotools pkgconfig update-rc.d systemd gobject-introspection-data
>
> INITSCRIPT_NAME =3D "ofono"
> INITSCRIPT_PARAMS =3D "defaults 22"
> SYSTEMD_SERVICE_${PN} =3D "ofono.service"
>
> PACKAGECONFIG ??=3D "\
>     ${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)} \
>     ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'bluez', '', d)}=
 \
> "
> PACKAGECONFIG[systemd] =3D
> "--with-systemdunitdir=3D${systemd_unitdir}/system/,--with-systemdunitdir=
=3D"
> PACKAGECONFIG[bluez] =3D "--enable-bluetooth, --disable-bluetooth, bluez5"
>
> EXTRA_OECONF +=3D "--enable-test --enable-external-ell"
>
> do_install_append() {
>   install -d ${D}${sysconfdir}/init.d/
>   install -m 0755 ${WORKDIR}/ofono ${D}${sysconfdir}/init.d/ofono
> }
>
> PACKAGES =3D+ "${PN}-tests"
>
> FILES_${PN} +=3D "${systemd_unitdir}"
> FILES_${PN}-tests =3D "${libdir}/${BPN}/test"
>
> RDEPENDS_${PN} +=3D "dbus"
> RDEPENDS_${PN}-tests =3D "\
>     python3-core \
>     python3-dbus \
>     ${@bb.utils.contains('GI_DATA_ENABLED', 'True',
> 'python3-pygobject', '', d)} \
> "
>
> RRECOMMENDS_${PN} +=3D "kernel-module-tun mobile-broadband-provider-info"
>
> The build was fine, but running the v1.31 ofono.service crashed at
> udevng.c missing OFONO_DRIVER property, the ofono.service was repeated
> to be restarted every 6 seconds:
>
> .....
>
> ofonod[9005]: ../ofono-1.31/plugins/udevng.c:add_serial_device()
> Device is missing required OFONO_DRIVER property
> ofonod[9005]: ../ofono-1.31/plugins/udevng.c:add_serial_device()
> Device is missing required OFONO_DRIVER property
> ......
>
> I am not quite sure if it is ofono 1.31 problem or oe-core
> ofono_1.31.bb problem, could anyone have a look at and advise? Let me
> know if you need more debug information.
>
> Thank you.
>
> Kind regards,
>
> - jupiter
>
>
> On 8/20/21, Jupiter <jupiter.hce@gmail.com> wrote:
> > Hi,
> >
> > I upgraded from Zeus to Hardknotte, I was able to run dbus to get
> > interface properties, but I failed on Hardknotte ofono 1.31. Has
> > anyone got oFono 1.31 dbus work?
> >
> > Thank you.
> >
> > Kind regards,
> >
> > - jupiter
> >
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
>

--===============1108901924795112333==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtc2l6
ZTpzbWFsbCI+SGkganVwaXRlciw8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHls
ZT0iZm9udC1zaXplOnNtYWxsIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+UGxlYXNlIHRyeSB0byB1cGRhdGUgb2Zvbm8gdG8gdGhl
IGxhdGVzdCByZWxlYXNlLiBTZWVtcyB0byBiZSBhIGxpYnJhcnkgaW5jb21wYXRpYmlsaXR5IGlz
c3VlIG9yIHNvbWV0aGluZyBsaWtlwqB0aGF0LjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1
bHQiIHN0eWxlPSJmb250LXNpemU6c21hbGwiPjxicj48L2Rpdj48ZGl2PjxkaXYgZGlyPSJsdHIi
IGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiIGRhdGEtc21hcnRtYWlsPSJnbWFpbF9zaWduYXR1cmUi
PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJs
dHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXY+PGZvbnQgZmFjZT0iYXJpYWwg
bmFycm93LCBzYW5zLXNlcmlmIj5Zb3VycyBzaW5jZXJlbHksPC9mb250PjwvZGl2PjxkaXY+PHNw
YW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O2FyaWFsIG5hcnJvdyZxdW90OyxzYW5zLXNlcmlm
Ij5TZXJnZWnCoDwvc3Bhbj48Zm9udCBmYWNlPSJhcmlhbCBuYXJyb3csIHNhbnMtc2VyaWYiPkdv
bHVidHNvdi48L2ZvbnQ+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+
PC9kaXY+PC9kaXY+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBk
aXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFNhdCwgQXVnIDIxLCAyMDIxIGF0IDQ6MDkg
QU0gSnVwaXRlciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmp1cGl0ZXIuaGNlQGdtYWlsLmNvbSI+anVw
aXRlci5oY2VAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXIt
bGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSw8YnI+
Cjxicj4KSSBidWlsZCBvZm9ubyB2MS4zMSBmcm9tIGdpdDovLzxhIGhyZWY9Imh0dHA6Ly9naXQu
eW9jdG9wcm9qZWN0Lm9yZy9wb2t5IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5n
aXQueW9jdG9wcm9qZWN0Lm9yZy9wb2t5PC9hPiBicmFuY2ggaGFyZGtub3R0LDxicj4KPGJyPgok
IGNhdCBtZXRhL3JlY2lwZXMtY29ubmVjdGl2aXR5L29mb25vLzxhIGhyZWY9Imh0dHA6Ly9vZm9u
b18xLjMxLmJiIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5vZm9ub18xLjMxLmJi
PC9hPjxicj4KPGJyPgpTVU1NQVJZID0gJnF1b3Q7b3BlbiBzb3VyY2UgdGVsZXBob255JnF1b3Q7
PGJyPgpERVNDUklQVElPTiA9ICZxdW90O29Gb25vIGlzIGEgc3RhY2sgZm9yIG1vYmlsZSB0ZWxl
cGhvbnkgZGV2aWNlcyBvbiBMaW51eC48YnI+Cm9Gb25vIHN1cHBvcnRzIHNwZWFraW5nIHRvIHRl
bGVwaG9ueSBkZXZpY2VzIHRocm91Z2ggc3BlY2lmaWMgZHJpdmVycyw8YnI+Cm9yIHdpdGggZ2Vu
ZXJpYyBBVCBjb21tYW5kcy4mcXVvdDs8YnI+CkhPTUVQQUdFID0gJnF1b3Q7PGEgaHJlZj0iaHR0
cDovL3d3dy5vZm9uby5vcmciIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6
Ly93d3cub2Zvbm8ub3JnPC9hPiZxdW90Ozxicj4KQlVHVFJBQ0tFUiA9ICZxdW90OzxhIGhyZWY9
Imh0dHBzOi8vMDEub3JnL2ppcmEvYnJvd3NlL09GIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0i
X2JsYW5rIj5odHRwczovLzAxLm9yZy9qaXJhL2Jyb3dzZS9PRjwvYT4mcXVvdDs8YnI+CkxJQ0VO
U0UgPSAmcXVvdDtHUEx2MiZxdW90Ozxicj4KTElDX0ZJTEVTX0NIS1NVTSA9ICZxdW90O2ZpbGU6
Ly9DT1BZSU5HO21kNT1lYjcyM2I2MTUzOWZlZWYwMTNkZTQ3NmU2OGI1YzUwYSBcPGJyPgo8YnI+
CmZpbGU6Ly9zcmMvb2Zvbm8uaDtiZWdpbmxpbmU9MTtlbmRsaW5lPTIwO21kNT0zY2UxN2Q1OTc4
ZWYzNDQ1ZGVmMjY1Yjk4ODk5YzJlZSZxdW90Ozxicj4KREVQRU5EUyA9ICZxdW90O2RidXMgZ2xp
Yi0yLjAgdWRldiBtb2JpbGUtYnJvYWRiYW5kLXByb3ZpZGVyLWluZm8gZWxsJnF1b3Q7PGJyPgo8
YnI+ClNSQ19VUkkgPSAmcXVvdDtcPGJyPgrCoCDCoCAke0tFUk5FTE9SR19NSVJST1J9L2xpbnV4
L25ldHdvcmsvJHtCUE59LyR7QlB9LnRhci54eiBcPGJyPgrCoCDCoCBmaWxlOi8vb2Zvbm8gXDxi
cj4KwqAgwqAgZmlsZTovLzAwMDEtbWJpbS1hZGQtYW4tb3B0aW9uYWwtVEVNUF9GQUlMVVJFX1JF
VFJZLW1hY3JvLWNvcHkucGF0Y2ggXDxicj4KJnF1b3Q7PGJyPgpTUkNfVVJJW21kNXN1bV0gPSAm
cXVvdDsxYzI2MzQwZTNjNmVkMTMyY2M4MTI1OTUwODFiYjNkYyZxdW90Ozxicj4KU1JDX1VSSVtz
aGEyNTZzdW1dID08YnI+CiZxdW90O2ExNWM1ZDI4MDk2YzEwZWIzMGU0N2E2OGI2ZGMyZTdjNGE1
YTk5ZDdmNGNmZWRmMGI2OTYyNGYzM2Q4NTllOWImcXVvdDs8YnI+Cjxicj4KaW5oZXJpdCBhdXRv
dG9vbHMgcGtnY29uZmlnIHVwZGF0ZS1yYy5kIHN5c3RlbWQgZ29iamVjdC1pbnRyb3NwZWN0aW9u
LWRhdGE8YnI+Cjxicj4KSU5JVFNDUklQVF9OQU1FID0gJnF1b3Q7b2Zvbm8mcXVvdDs8YnI+CklO
SVRTQ1JJUFRfUEFSQU1TID0gJnF1b3Q7ZGVmYXVsdHMgMjImcXVvdDs8YnI+ClNZU1RFTURfU0VS
VklDRV8ke1BOfSA9ICZxdW90O29mb25vLnNlcnZpY2UmcXVvdDs8YnI+Cjxicj4KUEFDS0FHRUNP
TkZJRyA/Pz0gJnF1b3Q7XDxicj4KwqAgwqAgJHtAYmIudXRpbHMuZmlsdGVyKCYjMzk7RElTVFJP
X0ZFQVRVUkVTJiMzOTssICYjMzk7c3lzdGVtZCYjMzk7LCBkKX0gXDxicj4KwqAgwqAgJHtAYmIu
dXRpbHMuY29udGFpbnMoJiMzOTtESVNUUk9fRkVBVFVSRVMmIzM5OywgJiMzOTtibHVldG9vdGgm
IzM5OywgJiMzOTtibHVleiYjMzk7LCAmIzM5OyYjMzk7LCBkKX0gXDxicj4KJnF1b3Q7PGJyPgpQ
QUNLQUdFQ09ORklHW3N5c3RlbWRdID08YnI+CiZxdW90Oy0td2l0aC1zeXN0ZW1kdW5pdGRpcj0k
e3N5c3RlbWRfdW5pdGRpcn0vc3lzdGVtLywtLXdpdGgtc3lzdGVtZHVuaXRkaXI9JnF1b3Q7PGJy
PgpQQUNLQUdFQ09ORklHW2JsdWV6XSA9ICZxdW90Oy0tZW5hYmxlLWJsdWV0b290aCwgLS1kaXNh
YmxlLWJsdWV0b290aCwgYmx1ZXo1JnF1b3Q7PGJyPgo8YnI+CkVYVFJBX09FQ09ORiArPSAmcXVv
dDstLWVuYWJsZS10ZXN0IC0tZW5hYmxlLWV4dGVybmFsLWVsbCZxdW90Ozxicj4KPGJyPgpkb19p
bnN0YWxsX2FwcGVuZCgpIHs8YnI+CsKgIGluc3RhbGwgLWQgJHtEfSR7c3lzY29uZmRpcn0vaW5p
dC5kLzxicj4KwqAgaW5zdGFsbCAtbSAwNzU1ICR7V09SS0RJUn0vb2Zvbm8gJHtEfSR7c3lzY29u
ZmRpcn0vaW5pdC5kL29mb25vPGJyPgp9PGJyPgo8YnI+ClBBQ0tBR0VTID0rICZxdW90OyR7UE59
LXRlc3RzJnF1b3Q7PGJyPgo8YnI+CkZJTEVTXyR7UE59ICs9ICZxdW90OyR7c3lzdGVtZF91bml0
ZGlyfSZxdW90Ozxicj4KRklMRVNfJHtQTn0tdGVzdHMgPSAmcXVvdDske2xpYmRpcn0vJHtCUE59
L3Rlc3QmcXVvdDs8YnI+Cjxicj4KUkRFUEVORFNfJHtQTn0gKz0gJnF1b3Q7ZGJ1cyZxdW90Ozxi
cj4KUkRFUEVORFNfJHtQTn0tdGVzdHMgPSAmcXVvdDtcPGJyPgrCoCDCoCBweXRob24zLWNvcmUg
XDxicj4KwqAgwqAgcHl0aG9uMy1kYnVzIFw8YnI+CsKgIMKgICR7QGJiLnV0aWxzLmNvbnRhaW5z
KCYjMzk7R0lfREFUQV9FTkFCTEVEJiMzOTssICYjMzk7VHJ1ZSYjMzk7LDxicj4KJiMzOTtweXRo
b24zLXB5Z29iamVjdCYjMzk7LCAmIzM5OyYjMzk7LCBkKX0gXDxicj4KJnF1b3Q7PGJyPgo8YnI+
ClJSRUNPTU1FTkRTXyR7UE59ICs9ICZxdW90O2tlcm5lbC1tb2R1bGUtdHVuIG1vYmlsZS1icm9h
ZGJhbmQtcHJvdmlkZXItaW5mbyZxdW90Ozxicj4KPGJyPgpUaGUgYnVpbGQgd2FzIGZpbmUsIGJ1
dCBydW5uaW5nIHRoZSB2MS4zMSBvZm9uby5zZXJ2aWNlIGNyYXNoZWQgYXQ8YnI+CnVkZXZuZy5j
IG1pc3NpbmcgT0ZPTk9fRFJJVkVSIHByb3BlcnR5LCB0aGUgb2Zvbm8uc2VydmljZSB3YXMgcmVw
ZWF0ZWQ8YnI+CnRvIGJlIHJlc3RhcnRlZCBldmVyeSA2IHNlY29uZHM6PGJyPgo8YnI+Ci4uLi4u
PGJyPgo8YnI+Cm9mb25vZFs5MDA1XTogLi4vb2Zvbm8tMS4zMS9wbHVnaW5zL3VkZXZuZy5jOmFk
ZF9zZXJpYWxfZGV2aWNlKCk8YnI+CkRldmljZSBpcyBtaXNzaW5nIHJlcXVpcmVkIE9GT05PX0RS
SVZFUiBwcm9wZXJ0eTxicj4Kb2Zvbm9kWzkwMDVdOiAuLi9vZm9uby0xLjMxL3BsdWdpbnMvdWRl
dm5nLmM6YWRkX3NlcmlhbF9kZXZpY2UoKTxicj4KRGV2aWNlIGlzIG1pc3NpbmcgcmVxdWlyZWQg
T0ZPTk9fRFJJVkVSIHByb3BlcnR5PGJyPgouLi4uLi48YnI+Cjxicj4KSSBhbSBub3QgcXVpdGUg
c3VyZSBpZiBpdCBpcyBvZm9ubyAxLjMxIHByb2JsZW0gb3Igb2UtY29yZTxicj4KPGEgaHJlZj0i
aHR0cDovL29mb25vXzEuMzEuYmIiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPm9m
b25vXzEuMzEuYmI8L2E+IHByb2JsZW0sIGNvdWxkIGFueW9uZSBoYXZlIGEgbG9vayBhdCBhbmQg
YWR2aXNlPyBMZXQgbWU8YnI+Cmtub3cgaWYgeW91IG5lZWQgbW9yZSBkZWJ1ZyBpbmZvcm1hdGlv
bi48YnI+Cjxicj4KVGhhbmsgeW91Ljxicj4KPGJyPgpLaW5kIHJlZ2FyZHMsPGJyPgo8YnI+Ci0g
anVwaXRlcjxicj4KPGJyPgo8YnI+Ck9uIDgvMjAvMjEsIEp1cGl0ZXIgJmx0OzxhIGhyZWY9Im1h
aWx0bzpqdXBpdGVyLmhjZUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5qdXBpdGVyLmhjZUBn
bWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+CiZndDsgSGksPGJyPgomZ3Q7PGJyPgomZ3Q7IEkg
dXBncmFkZWQgZnJvbSBaZXVzIHRvIEhhcmRrbm90dGUsIEkgd2FzIGFibGUgdG8gcnVuIGRidXMg
dG8gZ2V0PGJyPgomZ3Q7IGludGVyZmFjZSBwcm9wZXJ0aWVzLCBidXQgSSBmYWlsZWQgb24gSGFy
ZGtub3R0ZSBvZm9ubyAxLjMxLiBIYXM8YnI+CiZndDsgYW55b25lIGdvdCBvRm9ubyAxLjMxIGRi
dXMgd29yaz88YnI+CiZndDs8YnI+CiZndDsgVGhhbmsgeW91Ljxicj4KJmd0Ozxicj4KJmd0OyBL
aW5kIHJlZ2FyZHMsPGJyPgomZ3Q7PGJyPgomZ3Q7IC0ganVwaXRlcjxicj4KJmd0Ozxicj4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1h
aWxpbmcgbGlzdCAtLSA8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9i
bGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFp
bCB0byA8YSBocmVmPSJtYWlsdG86b2Zvbm8tbGVhdmVAb2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFu
ayI+b2Zvbm8tbGVhdmVAb2Zvbm8ub3JnPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============1108901924795112333==--

