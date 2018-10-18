Content-Type: multipart/mixed; boundary="===============4124028730311507508=="
MIME-Version: 1.0
From: Mattias =?unknown-8bit?q?M=C3=A5nsson?= <mattias.mansson@verisure.com>
Subject: Stuck in modem driver enable
Date: Thu, 18 Oct 2018 10:52:58 +0000
Message-ID: <AM4PR1001MB0786A11CCCAC698C6DE3A93196F80@AM4PR1001MB0786.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4124028730311507508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We have implemented a driver for the Gemalto modem we are using and today I=
 noticed that it got stuck in initialization (during enable). The problem i=
s that the AT+CFUN=3D4 (which is the last step of our init) now returned a =
CME error. The error handling for this is inspired from all the other drive=
rs:


static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
{
struct ofono_modem *modem =3D user_data;
struct verimalto_data *data =3D ofono_modem_get_data(modem);

if (!ok) {
g_at_chat_unref(data->app);
data->app =3D NULL;

g_at_chat_unref(data->mdm);
data->mdm =3D NULL;

ofono_modem_set_powered(modem, FALSE);
return;
}

// Get initial SIM state
data->sim_state_query =3D at_util_sim_state_query_new(data->app,
2, 20, sim_state_cb, modem,
NULL);
}


This will put the modem in not powered state. The problem is that as it has=
 not completed the initialization, there is now no interfaces at all set up=
. So we can not try to power it again or anything else. Are all these drive=
rs having an issue with error handling or have I missed something else? And=
 how could I handle it better?

--===============4124028730311507508==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD1pc28tODg1OS0xIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIiBzdHls
ZT0iZGlzcGxheTpub25lOyI+PCEtLSBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30g
LS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBkaXI9Imx0ciI+CjxkaXYgaWQ9ImRpdnRhZ2RlZmF1
bHR3cmFwcGVyIiBzdHlsZT0iZm9udC1zaXplOjEycHQ7Y29sb3I6IzAwMDAwMDtmb250LWZhbWls
eTpDYWxpYnJpLEhlbHZldGljYSxzYW5zLXNlcmlmOyIgZGlyPSJsdHIiPgo8cCBzdHlsZT0ibWFy
Z2luLXRvcDowO21hcmdpbi1ib3R0b206MCI+V2UgaGF2ZSBpbXBsZW1lbnRlZCBhIGRyaXZlciBm
b3IgdGhlIEdlbWFsdG8gbW9kZW0gd2UgYXJlIHVzaW5nIGFuZCB0b2RheSBJIG5vdGljZWQgdGhh
dCBpdCBnb3Qgc3R1Y2sgaW4gaW5pdGlhbGl6YXRpb24gKGR1cmluZyBlbmFibGUpLiBUaGUgcHJv
YmxlbSBpcyB0aGF0IHRoZSBBVCYjNDM7Q0ZVTj00ICh3aGljaCBpcyB0aGUgbGFzdCBzdGVwIG9m
IG91ciBpbml0KSBub3cgcmV0dXJuZWQKIGEgQ01FIGVycm9yLiBUaGUgZXJyb3IgaGFuZGxpbmcg
Zm9yIHRoaXMgaXMgaW5zcGlyZWQgZnJvbSBhbGwgdGhlIG90aGVyIGRyaXZlcnM6PC9wPgo8cCBz
dHlsZT0ibWFyZ2luLXRvcDowO21hcmdpbi1ib3R0b206MCI+PGJyPgo8L3A+CjxwIHN0eWxlPSJt
YXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowIj48L3A+CjxkaXY+c3RhdGljIHZvaWQgY2Z1bl9l
bmFibGUoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEp
PC9kaXY+CjxkaXY+ezwvZGl2Pgo8ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPjwv
c3Bhbj5zdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gdXNlcl9kYXRhOzwvZGl2Pgo8ZGl2Pjxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPjwvc3Bhbj5zdHJ1Y3QgdmVyaW1hbHRvX2RhdGEg
KmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7PC9kaXY+CjxkaXY+PGJyPgo8L2Rp
dj4KPGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj48L3NwYW4+aWYgKCFvaykgezwv
ZGl2Pgo8ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPjwvc3Bhbj5nX2F0X2NoYXRf
dW5yZWYoZGF0YS0mZ3Q7YXBwKTs8L2Rpdj4KPGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj48L3NwYW4+ZGF0YS0mZ3Q7YXBwID0gTlVMTDs8L2Rpdj4KPGRpdj48YnI+CjwvZGl2Pgo8
ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPjwvc3Bhbj5nX2F0X2NoYXRfdW5yZWYo
ZGF0YS0mZ3Q7bWRtKTs8L2Rpdj4KPGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj48
L3NwYW4+ZGF0YS0mZ3Q7bWRtID0gTlVMTDs8L2Rpdj4KPGRpdj48YnI+CjwvZGl2Pgo8ZGl2Pjxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPjwvc3Bhbj5vZm9ub19tb2RlbV9zZXRfcG93ZXJl
ZChtb2RlbSwgRkFMU0UpOzwvZGl2Pgo8ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pjwvc3Bhbj5yZXR1cm47PC9kaXY+CjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
PC9zcGFuPn08L2Rpdj4KPGRpdj48YnI+CjwvZGl2Pgo8ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPjwvc3Bhbj4vLyBHZXQgaW5pdGlhbCBTSU0gc3RhdGU8L2Rpdj4KPGRpdj48c3Bh
biBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj48L3NwYW4+ZGF0YS0mZ3Q7c2ltX3N0YXRlX3F1ZXJ5
ID0gYXRfdXRpbF9zaW1fc3RhdGVfcXVlcnlfbmV3KGRhdGEtJmd0O2FwcCw8L2Rpdj4KPGRpdj48
c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj48L3NwYW4+MiwgMjAsIHNpbV9zdGF0ZV9jYiwg
bW9kZW0sPC9kaXY+CjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+PC9zcGFuPk5V
TEwpOzwvZGl2Pgo8ZGl2Pn08L2Rpdj4KPGJyPgo8cD48L3A+CjxwIHN0eWxlPSJtYXJnaW4tdG9w
OjA7bWFyZ2luLWJvdHRvbTowIj5UaGlzIHdpbGwgcHV0IHRoZSBtb2RlbSBpbiBub3QmbmJzcDtw
b3dlcmVkIHN0YXRlLiBUaGUgcHJvYmxlbSBpcyB0aGF0IGFzIGl0IGhhcyBub3QgY29tcGxldGVk
IHRoZSBpbml0aWFsaXphdGlvbiwgdGhlcmUgaXMgbm93IG5vIGludGVyZmFjZXMgYXQgYWxsIHNl
dCB1cC4gU28gd2UgY2FuIG5vdCB0cnkgdG8gcG93ZXIgaXQgYWdhaW4gb3IgYW55dGhpbmcgZWxz
ZS4gQXJlJm5ic3A7YWxsIHRoZXNlCiBkcml2ZXJzIGhhdmluZyBhbiBpc3N1ZSB3aXRoIGVycm9y
IGhhbmRsaW5nJm5ic3A7b3IgaGF2ZSBJIG1pc3NlZCBzb21ldGhpbmcgZWxzZT8gQW5kIGhvdyBj
b3VsZCBJIGhhbmRsZSBpdCBiZXR0ZXI/PC9wPgo8L2Rpdj4KPC9ib2R5Pgo8L2h0bWw+Cg==

--===============4124028730311507508==--

