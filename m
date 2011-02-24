Content-Type: multipart/mixed; boundary="===============5861272874962548162=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC PATCH 2/3] ssn: add code and call id to notifications
Date: Thu, 24 Feb 2011 13:43:36 +0200
Message-ID: <4D664468.3090806@nokia.com>
In-Reply-To: <AANLkTi=XHVW0VteBvk2tkhbdwRdcDdMZmYAesMWSm9VR@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5861272874962548162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Sankar,

The call SS notification handling patches hasn't been (fully) applied, I =

think we need to do something about it.

Regards,
Andras


On 02/22/2011 02:07 PM, ext Sankar wrote:
> Hi Denis/Andras,
>
> Is this patch applied and available in the GIT?
>
> Regards,
> Sankar.
>
> On Thu, Feb 10, 2011 at 2:42 PM, Andras Domokos =

> <andras.domokos(a)nokia.com <mailto:andras.domokos@nokia.com>> wrote:
>
>     Hi Denis,
>
>
>     On 02/10/2011 05:08 AM, ext Denis Kenzior wrote:
>
>         Hi Andras,
>
>             diff --git a/include/ssn.h b/include/ssn.h
>             index d640cad..ba3701b 100644
>             --- a/include/ssn.h
>             +++ b/include/ssn.h
>             @@ -37,9 +37,10 @@ struct ofono_ssn_driver {
>              };
>
>              /* SSN notifications (CSSI and CSSU).  */
>             -void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int
>             code, int index);
>             -void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int
>             code, int index,
>             -                               const struct
>             ofono_phone_number *number);
>             +void ofono_ssn_cssi_notify(struct ofono_ssn *ssn,
>             unsigned int id,
>             +                               int code1, int index);
>             +void ofono_ssn_cssu_notify(struct ofono_ssn *ssn,
>             unsigned int id, int code2,
>             +                       int index, const struct
>             ofono_phone_number *number);
>
>              int ofono_ssn_driver_register(const struct
>             ofono_ssn_driver *d);
>              void ofono_ssn_driver_unregister(const struct
>             ofono_ssn_driver *d);
>
>         Right now I'm not seeing any users (or even potential ones) of
>         the SSN
>         atom besides voicecall.  What do you think of removing the SSN
>         atom and
>         moving these to the voicecall atom?
>
>     Yes, we talked about removing the SSN atom, but I thought I would
>     keep it for now, it can be removed any time later, anyways, doesn't
>     save much removing it.
>
>
>         The only one I'm not sure about is<code2>  from 27.007:
>         6       forward check SS message received (can be received
>         whenever)
>
>         Any idea what this one is about?
>
>     Never encountered this message, and I am not sure what is it for.
>     A patch for handling this message can be submitted later, if a real
>     life case is found for it.
>
>         Regards,
>         -Denis
>
>     Regards,
>     Andras
>
>     _______________________________________________
>     ofono mailing list
>     ofono(a)ofono.org <mailto:ofono@ofono.org>
>     http://lists.ofono.org/listinfo/ofono
>
>


--===============5861272874962548162==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFs
Ly9FTiI+CjxodG1sPgogIDxoZWFkPgogICAgPG1ldGEgY29udGVudD0idGV4dC9odG1sOyBjaGFy
c2V0PUlTTy04ODU5LTEiCiAgICAgIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSI+CiAgPC9oZWFk
PgogIDxib2R5IHRleHQ9IiMwMDAwMDAiIGJnY29sb3I9IiNmZmZmZmYiPgogICAgSGkgRGVuaXMg
YW5kIFNhbmthciw8YnI+CiAgICA8YnI+CiAgICBUaGUgY2FsbCBTUyBub3RpZmljYXRpb24gaGFu
ZGxpbmcgcGF0Y2hlcyBoYXNuJ3QgYmVlbiAoZnVsbHkpCiAgICBhcHBsaWVkLCBJIHRoaW5rIHdl
IG5lZWQgdG8gZG8gc29tZXRoaW5nIGFib3V0IGl0LiA8YnI+CiAgICA8YnI+CiAgICBSZWdhcmRz
LDxicj4KICAgIEFuZHJhczxicj4KICAgIDxicj4KICAgIDxicj4KICAgIE9uIDAyLzIyLzIwMTEg
MDI6MDcgUE0sIGV4dCBTYW5rYXIgd3JvdGU6CiAgICA8YmxvY2txdW90ZQogICAgICBjaXRlPSJt
aWQ6QUFOTGtUaT1YSFZXMFZ0ZUJ2azJ0a2hiZHdSZGNEZE1abVlBZXNNV1NtOVZSQG1haWwuZ21h
aWwuY29tIgogICAgICB0eXBlPSJjaXRlIj4KICAgICAgPG1ldGEgaHR0cC1lcXVpdj0iQ29udGVu
dC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7CiAgICAgICAgY2hhcnNldD1JU08tODg1OS0xIj4K
ICAgICAgSGkgRGVuaXMvQW5kcmFzLDxicj4KICAgICAgPGJyPgogICAgICBJcyB0aGlzIHBhdGNo
IGFwcGxpZWQgYW5kIGF2YWlsYWJsZSBpbiB0aGUgR0lUPzxicj4KICAgICAgPGJyPgogICAgICBS
ZWdhcmRzLDxicj4KICAgICAgU2Fua2FyLjxicj4KICAgICAgPGJyPgogICAgICA8ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+T24gVGh1LCBGZWIgMTAsIDIwMTEgYXQgMjo0MiBQTSwgQW5kcmFzCiAg
ICAgICAgRG9tb2tvcyA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIG1vei1kby1ub3Qtc2VuZD0idHJ1
ZSIKICAgICAgICAgICAgaHJlZj0ibWFpbHRvOmFuZHJhcy5kb21va29zQG5va2lhLmNvbSI+YW5k
cmFzLmRvbW9rb3NAbm9raWEuY29tPC9hPiZndDs8L3NwYW4+CiAgICAgICAgd3JvdGU6PGJyPgog
ICAgICAgIDxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0
OiAxcHggc29saWQKICAgICAgICAgIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0
IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OgogICAgICAgICAgMWV4OyI+SGkgRGVuaXMsCiAgICAg
ICAgICA8ZGl2IGNsYXNzPSJpbSI+PGJyPgogICAgICAgICAgICA8YnI+CiAgICAgICAgICAgIE9u
IDAyLzEwLzIwMTEgMDU6MDggQU0sIGV4dCBEZW5pcyBLZW56aW9yIHdyb3RlOjxicj4KICAgICAg
ICAgICAgPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6
IDFweAogICAgICAgICAgICAgIHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQg
MHB0IDBwdCAwLjhleDsKICAgICAgICAgICAgICBwYWRkaW5nLWxlZnQ6IDFleDsiPgogICAgICAg
ICAgICAgIEhpIEFuZHJhcyw8YnI+CiAgICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgIDxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHgKICAg
ICAgICAgICAgICAgIHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0IDBw
dCAwLjhleDsKICAgICAgICAgICAgICAgIHBhZGRpbmctbGVmdDogMWV4OyI+CiAgICAgICAgICAg
ICAgICBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zc24uaCBiL2luY2x1ZGUvc3NuLmg8YnI+CiAgICAg
ICAgICAgICAgICBpbmRleCBkNjQwY2FkLi5iYTM3MDFiIDEwMDY0NDxicj4KICAgICAgICAgICAg
ICAgIC0tLSBhL2luY2x1ZGUvc3NuLmg8YnI+CiAgICAgICAgICAgICAgICArKysgYi9pbmNsdWRl
L3Nzbi5oPGJyPgogICAgICAgICAgICAgICAgQEAgLTM3LDkgKzM3LDEwIEBAIHN0cnVjdCBvZm9u
b19zc25fZHJpdmVyIHs8YnI+CiAgICAgICAgICAgICAgICAmbmJzcDt9Ozxicj4KICAgICAgICAg
ICAgICAgIDxicj4KICAgICAgICAgICAgICAgICZuYnNwOy8qIFNTTiBub3RpZmljYXRpb25zIChD
U1NJIGFuZCBDU1NVKS4gJm5ic3A7Ki88YnI+CiAgICAgICAgICAgICAgICAtdm9pZCBvZm9ub19z
c25fY3NzaV9ub3RpZnkoc3RydWN0IG9mb25vX3NzbiAqc3NuLCBpbnQKICAgICAgICAgICAgICAg
IGNvZGUsIGludCBpbmRleCk7PGJyPgogICAgICAgICAgICAgICAgLXZvaWQgb2Zvbm9fc3NuX2Nz
c3Vfbm90aWZ5KHN0cnVjdCBvZm9ub19zc24gKnNzbiwgaW50CiAgICAgICAgICAgICAgICBjb2Rl
LCBpbnQgaW5kZXgsPGJyPgogICAgICAgICAgICAgICAgLSAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBjb25zdCBzdHJ1Y3QKICAgICAgICAgICAgICAgIG9m
b25vX3Bob25lX251bWJlciAqbnVtYmVyKTs8YnI+CiAgICAgICAgICAgICAgICArdm9pZCBvZm9u
b19zc25fY3NzaV9ub3RpZnkoc3RydWN0IG9mb25vX3NzbiAqc3NuLAogICAgICAgICAgICAgICAg
dW5zaWduZWQgaW50IGlkLDxicj4KICAgICAgICAgICAgICAgICsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgaW50IGNvZGUxLCBpbnQgaW5kZXgpOzxicj4K
ICAgICAgICAgICAgICAgICt2b2lkIG9mb25vX3Nzbl9jc3N1X25vdGlmeShzdHJ1Y3Qgb2Zvbm9f
c3NuICpzc24sCiAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgaWQsIGludCBjb2RlMiw8YnI+
CiAgICAgICAgICAgICAgICArICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgaW50IGluZGV4LCBjb25zdCBz
dHJ1Y3QKICAgICAgICAgICAgICAgIG9mb25vX3Bob25lX251bWJlciAqbnVtYmVyKTs8YnI+CiAg
ICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgICAmbmJzcDtpbnQgb2Zvbm9fc3NuX2Ry
aXZlcl9yZWdpc3Rlcihjb25zdCBzdHJ1Y3QKICAgICAgICAgICAgICAgIG9mb25vX3Nzbl9kcml2
ZXIgKmQpOzxicj4KICAgICAgICAgICAgICAgICZuYnNwO3ZvaWQgb2Zvbm9fc3NuX2RyaXZlcl91
bnJlZ2lzdGVyKGNvbnN0IHN0cnVjdAogICAgICAgICAgICAgICAgb2Zvbm9fc3NuX2RyaXZlciAq
ZCk7PGJyPgogICAgICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgICBSaWdodCBu
b3cgSSdtIG5vdCBzZWVpbmcgYW55IHVzZXJzIChvciBldmVuIHBvdGVudGlhbAogICAgICAgICAg
ICAgIG9uZXMpIG9mIHRoZSBTU048YnI+CiAgICAgICAgICAgICAgYXRvbSBiZXNpZGVzIHZvaWNl
Y2FsbC4gJm5ic3A7V2hhdCBkbyB5b3UgdGhpbmsgb2YgcmVtb3ZpbmcgdGhlCiAgICAgICAgICAg
ICAgU1NOIGF0b20gYW5kPGJyPgogICAgICAgICAgICAgIG1vdmluZyB0aGVzZSB0byB0aGUgdm9p
Y2VjYWxsIGF0b20/PGJyPgogICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICA8L2Rp
dj4KICAgICAgICAgIFllcywgd2UgdGFsa2VkIGFib3V0IHJlbW92aW5nIHRoZSBTU04gYXRvbSwg
YnV0IEkgdGhvdWdodCBJCiAgICAgICAgICB3b3VsZDxicj4KICAgICAgICAgIGtlZXAgaXQgZm9y
IG5vdywgaXQgY2FuIGJlIHJlbW92ZWQgYW55IHRpbWUgbGF0ZXIsIGFueXdheXMsCiAgICAgICAg
ICBkb2Vzbid0PGJyPgogICAgICAgICAgc2F2ZSBtdWNoIHJlbW92aW5nIGl0LgogICAgICAgICAg
PGRpdiBjbGFzcz0iaW0iPjxicj4KICAgICAgICAgICAgPGJyPgogICAgICAgICAgICA8YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdDogMXB4CiAgICAgICAg
ICAgICAgc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4
OwogICAgICAgICAgICAgIHBhZGRpbmctbGVmdDogMWV4OyI+CiAgICAgICAgICAgICAgVGhlIG9u
bHkgb25lIEknbSBub3Qgc3VyZSBhYm91dCBpcyZsdDtjb2RlMiZndDsgJm5ic3A7ZnJvbQogICAg
ICAgICAgICAgIDI3LjAwNzo8YnI+CiAgICAgICAgICAgICAgNiAmbmJzcDsgJm5ic3A7ICZuYnNw
OyBmb3J3YXJkIGNoZWNrIFNTIG1lc3NhZ2UgcmVjZWl2ZWQgKGNhbiBiZSByZWNlaXZlZAogICAg
ICAgICAgICAgIHdoZW5ldmVyKTxicj4KICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAg
QW55IGlkZWEgd2hhdCB0aGlzIG9uZSBpcyBhYm91dD88YnI+CiAgICAgICAgICAgICAgPGJyPgog
ICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIE5ldmVy
IGVuY291bnRlcmVkIHRoaXMgbWVzc2FnZSwgYW5kIEkgYW0gbm90IHN1cmUgd2hhdCBpcyBpdAog
ICAgICAgICAgZm9yLjxicj4KICAgICAgICAgIEEgcGF0Y2ggZm9yIGhhbmRsaW5nIHRoaXMgbWVz
c2FnZSBjYW4gYmUgc3VibWl0dGVkIGxhdGVyLCBpZiBhCiAgICAgICAgICByZWFsPGJyPgogICAg
ICAgICAgbGlmZSBjYXNlIGlzIGZvdW5kIGZvciBpdC48YnI+CiAgICAgICAgICA8YnI+CiAgICAg
ICAgICA8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdDog
MXB4IHNvbGlkCiAgICAgICAgICAgIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0
IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OgogICAgICAgICAgICAxZXg7Ij4KICAgICAgICAgICAg
UmVnYXJkcyw8YnI+CiAgICAgICAgICAgIC1EZW5pczxicj4KICAgICAgICAgIDwvYmxvY2txdW90
ZT4KICAgICAgICAgIFJlZ2FyZHMsPGJyPgogICAgICAgICAgPGZvbnQgY29sb3I9IiM4ODg4ODgi
PgogICAgICAgICAgICBBbmRyYXM8L2ZvbnQ+CiAgICAgICAgICA8ZGl2PgogICAgICAgICAgICA8
ZGl2IGNsYXNzPSJoNSI+PGJyPgogICAgICAgICAgICAgIF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fPGJyPgogICAgICAgICAgICAgIG9mb25vIG1haWxpbmcg
bGlzdDxicj4KICAgICAgICAgICAgICA8YSBtb3otZG8tbm90LXNlbmQ9InRydWUiIGhyZWY9Im1h
aWx0bzpvZm9ub0BvZm9uby5vcmciCiAgICAgICAgICAgICAgICB0YXJnZXQ9Il9ibGFuayI+b2Zv
bm9Ab2Zvbm8ub3JnPC9hPjxicj4KICAgICAgICAgICAgICA8YSBtb3otZG8tbm90LXNlbmQ9InRy
dWUiCiAgICAgICAgICAgICAgICBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZv
L29mb25vIgogICAgICAgICAgICAgICAgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0cy5vZm9u
by5vcmcvbGlzdGluZm8vb2Zvbm88L2E+PGJyPgogICAgICAgICAgICA8L2Rpdj4KICAgICAgICAg
IDwvZGl2PgogICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPC9kaXY+CiAgICAgIDxicj4KICAg
IDwvYmxvY2txdW90ZT4KICAgIDxicj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============5861272874962548162==--

