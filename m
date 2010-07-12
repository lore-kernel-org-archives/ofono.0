Content-Type: multipart/mixed; boundary="===============6096933911302656594=="
MIME-Version: 1.0
From: s s <sk53901@gmail.com>
Subject: problem when setting "VoiceNoReplyTimeout" property in call-forwarding
Date: Mon, 12 Jul 2010 16:59:43 +0530
Message-ID: <AANLkTim5cWQ2rWlWfYw-UGgPFfUH3gFBax_FoBRHh9Dx@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6096933911302656594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all ,

        In ofono call-forwarding use cases , i am trying to set
"VoiceNoReplyTimeout" property which is of type uint16 . below is the piece
of code

uint time_out=3D15;
GValue val=3DG_VALUE_INIT;
g_value_init(&val,G_TYPE_UINT);
GError *error=3DNULL;
g_value_set_uint(&val,time_out);
    if(!dbus_g_proxy_call (proxy, "SetProperty", &error,
G_TYPE_STRING,"VoiceNoReplyTimeout", G_TYPE_VALUE,&val, G_TYPE_INVALID,
G_TYPE_INVALID))
    {
                   g_print("failed\n %s ",error->message);
    }


if i execute the above  piece of code i am getting error ->"Invalid
arguments in method call"

i tried to look into the ofono soruce code , in that i tried to get the data
types what it is expecting , and i got with numbers 117 and 113
g_print("\n arg type %d %d \n"
,dbus_message_iter_get_arg_type(&var),DBUS_TYPE_UINT16)


when i checked the number references in DBus specification  i found
UINT16    113 (ASCII 'q')

how to add an unint16 value to a GValue ?

--===============6096933911302656594==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgYWxsICw8YnI+PGJyPqCgoKCgoKAgSW4gb2Zvbm8gY2FsbC1mb3J3YXJkaW5nIHVzZSBjYXNl
cyAsIGkgYW0gdHJ5aW5nIHRvIHNldCAmcXVvdDtWb2ljZU5vUmVwbHlUaW1lb3V0JnF1b3Q7IHBy
b3BlcnR5IHdoaWNoIGlzIG9mIHR5cGUgdWludDE2IC4gYmVsb3cgaXMgdGhlIHBpZWNlIG9mIGNv
ZGU8YnI+PGJyPnVpbnQgdGltZV9vdXQ9MTU7PGJyPkdWYWx1ZSB2YWw9R19WQUxVRV9JTklUOzxi
cj4KZ192YWx1ZV9pbml0KCZhbXA7dmFsLEdfVFlQRV9VSU5UKTs8YnI+R0Vycm9yICplcnJvcj1O
VUxMOzxicj5nX3ZhbHVlX3NldF91aW50KCZhbXA7dmFsLHRpbWVfb3V0KTs8YnI+oKCgIGlmKCFk
YnVzX2dfcHJveHlfY2FsbCAocHJveHksICZxdW90O1NldFByb3BlcnR5JnF1b3Q7LCAmYW1wO2Vy
cm9yLCBHX1RZUEVfU1RSSU5HLCZxdW90O1ZvaWNlTm9SZXBseVRpbWVvdXQmcXVvdDssIEdfVFlQ
RV9WQUxVRSwmYW1wO3ZhbCwgR19UWVBFX0lOVkFMSUQsIEdfVFlQRV9JTlZBTElEKSk8YnI+CqCg
oCB7PGJyPqCgoKCgoCCgoKAgoKCgoKCgoCBnX3ByaW50KCZxdW90O2ZhaWxlZFxuICVzICZxdW90
OyxlcnJvci0mZ3Q7bWVzc2FnZSk7PGJyPqCgoCB9PGJyPjxicj48YnI+aWYgaSBleGVjdXRlIHRo
ZSBhYm92ZaAgcGllY2Ugb2YgY29kZSBpIGFtIGdldHRpbmcgZXJyb3IgLSZndDsmcXVvdDtJbnZh
bGlkIGFyZ3VtZW50cyBpbiBtZXRob2QgY2FsbCZxdW90Ozxicj48YnI+aSB0cmllZCB0byBsb29r
IGludG8gdGhlIG9mb25vIHNvcnVjZSBjb2RlICwgaW4gdGhhdCBpIHRyaWVkIHRvIGdldCB0aGUg
ZGF0YSB0eXBlcyB3aGF0IGl0IGlzIGV4cGVjdGluZyAsIGFuZCBpIGdvdCB3aXRoIG51bWJlcnMg
MTE3IGFuZCAxMTM8YnI+CmdfcHJpbnQoJnF1b3Q7XG4gYXJnIHR5cGUgJWQgJWQgXG4mcXVvdDsg
LGRidXNfbWVzc2FnZV9pdGVyX2dldF9hcmdfdHlwZSgmYW1wO3ZhciksREJVU19UWVBFX1VJTlQx
Nik8YnI+PGJyPjxicj53aGVuIGkgY2hlY2tlZCB0aGUgbnVtYmVyIHJlZmVyZW5jZXMgaW4gREJ1
cyBzcGVjaWZpY2F0aW9uoCBpIGZvdW5kIDxicj5VSU5UMTagoKAgMTEzIChBU0NJSSAmIzM5O3Em
IzM5Oyk8YnI+Cjxicj5ob3cgdG8gYWRkIGFuIHVuaW50MTYgdmFsdWUgdG8gYSBHVmFsdWUgPzxi
cj48YnI+PGJyPgo=

--===============6096933911302656594==--

