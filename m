Content-Type: multipart/mixed; boundary="===============1270548979709006667=="
MIME-Version: 1.0
From: Sergei Golubtsov <s.e.golubtsov@gmail.com>
Subject: Re: Quectel EC200T USB: Problems with context activation
Date: Sat, 02 Jan 2021 10:52:08 +0100
Message-ID: <CAFiQ676_iC_LYet=Dg3gH0Ci2_-VEJc=gnKycQuBuwaDWVCYpQ@mail.gmail.com>
In-Reply-To: <CAFiQ675t6c9sn_fiYf+4334cpY6fP0DmCaPXREQ82rV3uC15_A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1270548979709006667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> The log from my previous message clearly shows that the problem is that
> the modem stopped escaping control characters (<0x20) with 0x7d when phase
> 2 had begun. Apparently pppd is ok with this behaviour. Am going to compa=
re
> the HLDC frame parsers in pppd and ofono. Is it a modem bug or an ofono
> missing feature? Any help will be appreciated.
>
I have found the problem. ofono does not apply ACCM, which is proposed by
the DCE in a configuration request. The EC200 Quectel modem uses ACCM =3D
0x00000000 in the authentication phase and ofono ACK such configuration but
does not apply configuration options. That is why ofono silently drops some
frames from the DCE in phase 2 and does not answer to packets because the
FCS (CRC) of packets does not match the value calculated by ofono. I have
sent a patch, which solves the problem.
I am concerned about two things:
1. Did I choose the right place to insert the configuration options
application code?
2. ACCM is for asynchronous links only. Does ofono support other links? If
so we must check the link type before applying the ACCM configuration
option as suggested in RFC 1812
<https://www.freesoft.org/CIE/RFC/1812/index.htm> 3.3.5.2.

Regards,
Sergei.

--===============1270548979709006667==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+SGkgRGVuaXMsPC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90
ZSI+PGRpdiBzdHlsZT0iZm9udC1zaXplOnNtYWxsIj5UaGUgbG9nIGZyb20gbXkgcHJldmlvdXMg
bWVzc2FnZSBjbGVhcmx5IHNob3dzIHRoYXQgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgbW9kZW0g
c3RvcHBlZCBlc2NhcGluZyBjb250cm9sIGNoYXJhY3RlcnMgKCZsdDsweDIwKSB3aXRoIDB4N2Qg
d2hlbiBwaGFzZSAyIGhhZCBiZWd1bi4gQXBwYXJlbnRseSBwcHBkIGlzIG9rIHdpdGggdGhpcyBi
ZWhhdmlvdXIuIEFtIGdvaW5nIHRvIGNvbXBhcmUgdGhlIEhMREPCoGZyYW1lIHBhcnNlcnPCoGlu
IHBwcGQgYW5kIG9mb25vLiBJcyBpdCBhIG1vZGVtIGJ1ZyBvciBhbiBvZm9ubyBtaXNzaW5nIGZl
YXR1cmU/IEFueSBoZWxwIHdpbGwgYmUgYXBwcmVjaWF0ZWQuPC9kaXY+PC9kaXY+PC9kaXY+PC9i
bG9ja3F1b3RlPjxkaXY+PHNwYW4gY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LXNp
emU6c21hbGwiPkkgaGF2ZSBmb3VuZCB0aGUgcHJvYmxlbS4gb2Zvbm8gZG9lcyBub3QgYXBwbHkg
QUNDTSwgd2hpY2ggaXMgcHJvcG9zZWQgYnkgdGhlIERDRSBpbiBhIGNvbmZpZ3VyYXRpb24gcmVx
dWVzdC4gVGhlIEVDMjAwIFF1ZWN0ZWwgbW9kZW0gdXNlcyBBQ0NNID0gMHgwMDAwMDAwMCBpbiB0
aGUgYXV0aGVudGljYXRpb24gcGhhc2UgYW5kIG9mb25vIEFDSyBzdWNoIGNvbmZpZ3VyYXRpb24g
YnV0IGRvZXMgbm90IGFwcGx5IGNvbmZpZ3VyYXRpb24gb3B0aW9ucy4gVGhhdCBpcyB3aHkgb2Zv
bm8gc2lsZW50bHnCoGRyb3BzIHNvbWUgZnJhbWVzIGZyb20gdGhlIERDRSBpbiBwaGFzZSAyIGFu
ZCBkb2VzIG5vdCBhbnN3ZXIgdG8gcGFja2V0cyBiZWNhdXNlIHRoZSBGQ1MgKENSQykgb2YgcGFj
a2V0cyBkb2VzIG5vdCBtYXRjaCB0aGUgdmFsdWUgY2FsY3VsYXRlZCBieSBvZm9uby4gSSBoYXZl
IHNlbnQgYSBwYXRjaCwgd2hpY2jCoHNvbHZlcyB0aGUgcHJvYmxlbS7CoDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuIGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1zaXplOnNtYWxsIj5J
IGFtIGNvbmNlcm5lZCBhYm91dCB0d28gdGhpbmdzOjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1zaXplOnNtYWxsIj4xLiBEaWQgSSBjaG9v
c2UgdGhlIHJpZ2h0IHBsYWNlIHRvIGluc2VydCB0aGUgY29uZmlndXJhdGlvbiBvcHRpb25zIGFw
cGxpY2F0aW9uIGNvZGU/PC9zcGFuPjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+Mi4gQUNDTSBpcyBmb3IgYXN5bmNocm9ub3VzIGxp
bmtzIG9ubHkuIERvZXMgb2Zvbm8gc3VwcG9ydCBvdGhlciBsaW5rcz8gSWYgc28gd2UgbXVzdCBj
aGVjayB0aGUgbGluayB0eXBlIGJlZm9yZSBhcHBseWluZyB0aGUgQUNDTSBjb25maWd1cmF0aW9u
IG9wdGlvbiBhcyBzdWdnZXN0ZWQgaW7CoDxhIGhyZWY9Imh0dHBzOi8vd3d3LmZyZWVzb2Z0Lm9y
Zy9DSUUvUkZDLzE4MTIvaW5kZXguaHRtIiBzdHlsZT0iY29sb3I6cmdiKDUxLDE0NSwyNTUpO2Zv
bnQtZmFtaWx5OlRpbm9zO2ZvbnQtc2l6ZTptZWRpdW07dGV4dC1hbGlnbjotd2Via2l0LWNlbnRl
ciI+UkZDIDE4MTI8L2E+wqAzLjMuNS4yLjwvZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LXNpemU6c21hbGwiPlJlZ2FyZHMsPC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+U2VyZ2VpLjwv
ZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj4K

--===============1270548979709006667==--

