Content-Type: multipart/mixed; boundary="===============2725230618225114182=="
MIME-Version: 1.0
From: Nikolas Sepos <nikolas@endocode.com>
Subject: GPRS Attach/Detach
Date: Wed, 14 Feb 2018 11:03:57 +0100
Message-ID: <CAKsXZz2n2Wgy94aNuJa0x643Gc-YQ6OVPJoamMzht0DBM-CmTA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2725230618225114182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello ofono maintainers,

i had an issue with a modem and the GPRS attach/detach command. It was
hanging my modem for 3 seconds (modem issue not ofono). So in order to work
around it i implemented attach and detach as NoOp (not sending
AT+CGATT=3D0/1) but still had to callback to ofono that i am attached or
detached. But in order for that to make it work i had to patch src/gprs.c

Here is the function i made changes to:

static void gprs_attached_update(struct ofono_gprs *gprs)
{
        ofono_bool_t attached;

        attached =3D gprs->driver_attached &&
                (gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED=
 ||
                        gprs->status =3D=3D
NETWORK_REGISTRATION_STATUS_ROAMING);

        if (attached =3D=3D gprs->attached)
                return;

        /*
         * If an active context is found, a PPP session might be still
active
         * at driver level. "Attached" =3D TRUE property can't be signalled=
 to
         * the applications registered on GPRS properties.
         * Active contexts have to be release at driver level.
         */
        if (attached =3D=3D FALSE) {
                release_active_contexts(gprs);
                gprs->bearer =3D -1;
        } else if (have_active_contexts(gprs) =3D=3D TRUE) {
                /*
                 * Some times the context activates after a detach event and
                 * right before an attach. We close it to avoid unexpected
open
                 * contexts.
                 */
                release_active_contexts(gprs);
                gprs->flags |=3D GPRS_FLAG_ATTACHED_UPDATE;
                return;
        }

        gprs_set_attached_property(gprs, attached);
}


I had to remove the `else if (have_active_contexts(gprs) =3D=3D TRUE) { ...=
 }`
block because when attached was TRUE i still had active context and i
didn't want it to be deactivated.

As the comments say it's to mitigate some PPP issues. Should that be the
case for all type of connections? What if my connection is RNDIS and not
PPP?

I hope i explained this well enough. If not please ask me to explain more.

Looking forward to your reply.

All the best,

---

Nikolas Sepos
DevOps Engineer @ Endocode AG
nikolas(a)endocode.com

------
Endocode AG, Br=C3=BCckenstra=C3=9Fe 5A, 10179 Berlin
info(a)endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Thomas Fricke, Sebastian Sucker
Aufsichtsratsvorsitzende: Alexandra Boehm

Registergericht: Amtsgericht
Charlottenburg - HRB 150748 B

--===============2725230618225114182==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGVsbG8gb2Zvbm8gbWFpbnRhaW5lcnMsPGRpdj48YnI+PC9kaXY+PGRp
dj5pIGhhZCBhbiBpc3N1ZSB3aXRoIGEgbW9kZW0gYW5kIHRoZSBHUFJTIGF0dGFjaC9kZXRhY2gg
Y29tbWFuZC4gSXQgd2FzIGhhbmdpbmcgbXkgbW9kZW0gZm9yIDMgc2Vjb25kcyAobW9kZW0gaXNz
dWUgbm90IG9mb25vKS4gU28gaW4gb3JkZXIgdG8gd29yayBhcm91bmQgaXQgaSBpbXBsZW1lbnRl
ZCBhdHRhY2ggYW5kIGRldGFjaCBhcyBOb09wIChub3Qgc2VuZGluZyBBVCtDR0FUVD0wLzEpIGJ1
dCBzdGlsbCBoYWQgdG8gY2FsbGJhY2sgdG8gb2Zvbm8gdGhhdCBpIGFtIGF0dGFjaGVkIG9yIGRl
dGFjaGVkLiBCdXQgaW4gb3JkZXIgZm9yIHRoYXQgdG8gbWFrZSBpdCB3b3JrIGkgaGFkIHRvIHBh
dGNoIHNyYy9ncHJzLmM8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkhlcmUgaXMgdGhlIGZ1bmN0
aW9uIGkgbWFkZSBjaGFuZ2VzIHRvOjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+c3RhdGljIHZv
aWQgZ3Byc19hdHRhY2hlZF91cGRhdGUoc3RydWN0IG9mb25vX2dwcnMgKmdwcnMpPC9kaXY+PGRp
dj57PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBvZm9ub19ib29sX3QgYXR0YWNoZWQ7PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBhdHRhY2hlZCA9IGdwcnMtJmd0O2RyaXZlcl9h
dHRhY2hlZCAmYW1wOyZhbXA7PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAoZ3By
cy0mZ3Q7c3RhdHVzID09IE5FVFdPUktfUkVHSVNUUkFUSU9OX1NUQVRVU19SRUdJU1RFUkVEIHx8
PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBncHJzLSZndDtz
dGF0dXMgPT0gTkVUV09SS19SRUdJU1RSQVRJT05fU1RBVFVTX1JPQU1JTkcpOzwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgaWYgKGF0dGFjaGVkID09IGdwcnMtJmd0O2F0dGFj
aGVkKTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuOzwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgLyo8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgKiBJ
ZiBhbiBhY3RpdmUgY29udGV4dCBpcyBmb3VuZCwgYSBQUFAgc2Vzc2lvbiBtaWdodCBiZSBzdGls
bCBhY3RpdmU8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgKiBhdCBkcml2ZXIgbGV2ZWwuICZxdW90
O0F0dGFjaGVkJnF1b3Q7ID0gVFJVRSBwcm9wZXJ0eSBjYW4mIzM5O3QgYmUgc2lnbmFsbGVkIHRv
PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCogdGhlIGFwcGxpY2F0aW9ucyByZWdpc3RlcmVkIG9u
IEdQUlMgcHJvcGVydGllcy48L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgKiBBY3RpdmUgY29udGV4
dHMgaGF2ZSB0byBiZSByZWxlYXNlIGF0IGRyaXZlciBsZXZlbC48L2Rpdj48ZGl2PsKgIMKgIMKg
IMKgIMKgKi88L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIGlmIChhdHRhY2hlZCA9PSBGQUxTRSkgezwv
ZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVsZWFzZV9hY3RpdmVfY29udGV4dHMo
Z3Bycyk7PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBncHJzLSZndDtiZWFyZXIg
PSAtMTs8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIH0gZWxzZSBpZiAoaGF2ZV9hY3RpdmVfY29udGV4
dHMoZ3BycykgPT0gVFJVRSkgezwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyo8
L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBTb21lIHRpbWVzIHRoZSBjb250
ZXh0IGFjdGl2YXRlcyBhZnRlciBhIGRldGFjaCBldmVudCBhbmQ8L2Rpdj48ZGl2PsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgKiByaWdodCBiZWZvcmUgYW4gYXR0YWNoLiBXZSBjbG9zZSBpdCB0
byBhdm9pZCB1bmV4cGVjdGVkIG9wZW48L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgKiBjb250ZXh0cy48L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKi88L2Rp
dj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlbGVhc2VfYWN0aXZlX2NvbnRleHRzKGdw
cnMpOzwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ3Bycy0mZ3Q7ZmxhZ3MgfD0g
R1BSU19GTEFHX0FUVEFDSEVEX1VQREFURTs8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJldHVybjs8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIH08L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PsKgIMKgIMKgIMKgIGdwcnNfc2V0X2F0dGFjaGVkX3Byb3BlcnR5KGdwcnMsIGF0dGFjaGVk
KTs8L2Rpdj48ZGl2Pn08L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkg
aGFkIHRvIHJlbW92ZSB0aGUgYGVsc2UgaWYgKGhhdmVfYWN0aXZlX2NvbnRleHRzKGdwcnMpID09
IFRSVUUpIHsgLi4uIH1gIGJsb2NrIGJlY2F1c2Ugd2hlbiBhdHRhY2hlZCB3YXMgVFJVRSBpIHN0
aWxsIGhhZCBhY3RpdmUgY29udGV4dCBhbmQgaSBkaWRuJiMzOTt0IHdhbnQgaXQgdG8gYmUgZGVh
Y3RpdmF0ZWQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BcyB0aGUgY29tbWVudHMgc2F5IGl0
JiMzOTtzIHRvIG1pdGlnYXRlIHNvbWUgUFBQIGlzc3Vlcy4gU2hvdWxkIHRoYXQgYmUgdGhlIGNh
c2UgZm9yIGFsbCB0eXBlIG9mIGNvbm5lY3Rpb25zPyBXaGF0IGlmIG15IGNvbm5lY3Rpb24gaXMg
Uk5ESVMgYW5kIG5vdCBQUFA/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGhvcGUgaSBleHBs
YWluZWQgdGhpcyB3ZWxsIGVub3VnaC4gSWYgbm90IHBsZWFzZSBhc2sgbWUgdG8gZXhwbGFpbiBt
b3JlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVw
bHkuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbGwgdGhlIGJlc3QsPC9kaXY+PGRpdj48ZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRp
cj0ibHRyIj48ZGl2PjxkaXYgZGlyPSJsdHIiPjxkaXY+PGRpdiBkaXI9Imx0ciI+PHAgZGlyPSJs
dHIiIHN0eWxlPSJsaW5lLWhlaWdodDoxLjE1O21hcmdpbi10b3A6MHB0O21hcmdpbi1ib3R0b206
MHB0Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEzcHg7Zm9udC1mYW1pbHk6QXJpYWw7Y29sb3I6
cmdiKDAsMCwwKTtiYWNrZ3JvdW5kLWNvbG9yOnRyYW5zcGFyZW50O2ZvbnQtd2VpZ2h0Om5vcm1h
bDtmb250LXN0eWxlOm5vcm1hbDtmb250LXZhcmlhbnQ6bm9ybWFsO3RleHQtZGVjb3JhdGlvbjpu
b25lO3ZlcnRpY2FsLWFsaWduOmJhc2VsaW5lIj4tLS08L3NwYW4+PC9wPjxwIGRpcj0ibHRyIiBz
dHlsZT0ibGluZS1oZWlnaHQ6MS4xNTttYXJnaW4tdG9wOjBwdDttYXJnaW4tYm90dG9tOjBwdCI+
PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxM3B4O2ZvbnQtZmFtaWx5OkFyaWFsO2NvbG9yOnJnYigw
LDAsMCk7YmFja2dyb3VuZC1jb2xvcjp0cmFuc3BhcmVudDtmb250LXdlaWdodDpub3JtYWw7Zm9u
dC1zdHlsZTpub3JtYWw7Zm9udC12YXJpYW50Om5vcm1hbDt0ZXh0LWRlY29yYXRpb246bm9uZTt2
ZXJ0aWNhbC1hbGlnbjpiYXNlbGluZSI+Tmlrb2xhcyBTZXBvczxicj5EZXZPcHMgRW5naW5lZXIg
QCBFbmRvY29kZSBBRzxicj48YSBocmVmPSJtYWlsdG86bmlrb2xhc0BlbmRvY29kZS5jb20iIHRh
cmdldD0iX2JsYW5rIj5uaWtvbGFzQGVuZG9jb2RlLmNvbTwvYT48YnI+PC9zcGFuPjwvcD48YnI+
PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxM3B4O2ZvbnQtZmFtaWx5OkFyaWFsO2NvbG9yOnJnYigw
LDAsMCk7YmFja2dyb3VuZC1jb2xvcjp0cmFuc3BhcmVudDtmb250LXdlaWdodDpub3JtYWw7Zm9u
dC1zdHlsZTpub3JtYWw7Zm9udC12YXJpYW50Om5vcm1hbDt0ZXh0LWRlY29yYXRpb246bm9uZTt2
ZXJ0aWNhbC1hbGlnbjpiYXNlbGluZSI+PC9zcGFuPjxwIGRpcj0ibHRyIiBzdHlsZT0ibGluZS1o
ZWlnaHQ6MS4xNTttYXJnaW4tdG9wOjBwdDttYXJnaW4tYm90dG9tOjBwdCI+PHNwYW4gc3R5bGU9
ImZvbnQtc2l6ZToxM3B4O2ZvbnQtZmFtaWx5OkFyaWFsO2NvbG9yOnJnYigwLDAsMCk7YmFja2dy
b3VuZC1jb2xvcjp0cmFuc3BhcmVudDtmb250LXdlaWdodDpub3JtYWw7Zm9udC1zdHlsZTpub3Jt
YWw7Zm9udC12YXJpYW50Om5vcm1hbDt0ZXh0LWRlY29yYXRpb246bm9uZTt2ZXJ0aWNhbC1hbGln
bjpiYXNlbGluZSI+LS0tLS0tPC9zcGFuPjwvcD48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjhw
eCI+RW5kb2NvZGUgQUcsIEJyw7xja2Vuc3RyYcOfZSA1QSwgMTAxNzkgQmVybGluPC9zcGFuPjxi
ciBzdHlsZT0iZm9udC1zaXplOjEyLjhweCI+PGEgaHJlZj0ibWFpbHRvOmluZm9AZW5kb2NvZGUu
Y29tIiBzdHlsZT0iY29sb3I6cmdiKDE3LDg1LDIwNCk7Zm9udC1zaXplOjEyLjhweCIgdGFyZ2V0
PSJfYmxhbmsiPmluZm9AZW5kb2NvZGUuY29tPC9hPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIu
OHB4Ij7CoHzCoDwvc3Bhbj48YSBocmVmPSJodHRwOi8vd3d3LmVuZG9jb2RlLmNvbS8iIHN0eWxl
PSJjb2xvcjpyZ2IoMTcsODUsMjA0KTtmb250LXNpemU6MTIuOHB4IiB0YXJnZXQ9Il9ibGFuayI+
d3d3LmVuZG9jb2RlLmNvbTwvYT48YnIgc3R5bGU9ImZvbnQtc2l6ZToxMi44cHgiPjxiciBzdHls
ZT0iZm9udC1zaXplOjEyLjhweCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi44cHgiPlZvcnN0
YW5kc3ZvcnNpdHplbmRlcjogTWlya28gQm9laG08L3NwYW4+PGJyIHN0eWxlPSJmb250LXNpemU6
MTIuOHB4Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjhweCI+Vm9yc3TDpG5kZTogRHIuIFRo
b21hcyBGcmlja2UsIFNlYmFzdGlhbiBTdWNrZXI8L3NwYW4+PGJyIHN0eWxlPSJmb250LXNpemU6
MTIuOHB4Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjhweCI+QXVmc2ljaHRzcmF0c3ZvcnNp
dHplbmRlOiBBbGV4YW5kcmEgQm9laG08L3NwYW4+PGJyIHN0eWxlPSJmb250LXNpemU6MTIuOHB4
Ij48YnIgc3R5bGU9ImZvbnQtc2l6ZToxMi44cHgiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIu
OHB4Ij5SZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0PC9zcGFuPjxiciBzdHlsZT0iZm9udC1z
aXplOjEyLjhweCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi44cHgiPkNoYXJsb3R0ZW5idXJn
IC0gSFJCIDE1MDc0OCBCPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTNweDtmb250LWZh
bWlseTpBcmlhbDtjb2xvcjpyZ2IoMCwwLDApO2JhY2tncm91bmQtY29sb3I6dHJhbnNwYXJlbnQ7
Zm9udC13ZWlnaHQ6bm9ybWFsO2ZvbnQtc3R5bGU6bm9ybWFsO2ZvbnQtdmFyaWFudDpub3JtYWw7
dGV4dC1kZWNvcmF0aW9uOm5vbmU7dmVydGljYWwtYWxpZ246YmFzZWxpbmUiPjwvc3Bhbj48L2Rp
dj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4KPC9kaXY+
PC9kaXY+Cg==

--===============2725230618225114182==--

