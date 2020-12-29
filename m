Content-Type: multipart/mixed; boundary="===============5342411403066369900=="
MIME-Version: 1.0
From: Sergei Golubtsov <s.e.golubtsov@gmail.com>
Subject: Re: Quectel EC200T USB: Problems with context activation
Date: Tue, 29 Dec 2020 16:55:10 +0100
Message-ID: <CAFiQ677Ovt4VJW8F9uO+4c85NsofS8Ex4GY2KPHZGshwS4duUA@mail.gmail.com>
In-Reply-To: <CAFiQ6740kA9Nmkz+pTt5MAd0=KgcNSaPQMOUwv5draJapDjt1Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5342411403066369900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the first email I was mistaken about the authentication method in pppd -
it is pap not chap. So, probably this is the problem. How can I change the
authentication method for the context activation in Ofono from default chap
to pap? Where is the best place to do it in the code?

Yours sincerely,
Sergei Golubtsov.


On Tue, Dec 29, 2020 at 3:09 PM Sergei Golubtsov <s.e.golubtsov@gmail.com>
wrote:

> Hello,
>
> I am trying to add support for the Quectel EC200T USB modem. This modem
> uses the option USB serial driver in the kernel.
> As other Quectel modems, this one uses the atmodem ofono driver.
>
> I cannot overcome the problem of context activation. It fails at
> "ofono/gatchat/gatppp.c:ppp_enter_phase() 2" after a minute.
> At the same time, I can successfully use pppd. Both pppd and ofono use the
> chap authentication method.
>
> Please find logs and the patch attached.
> Any suggestions will be appreciated.
>
> Yours sincerely,
> Sergei Golubtsov.
>

--===============5342411403066369900==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtc2l6
ZTpzbWFsbCI+SW4gdGhlIGZpcnN0IGVtYWlsIEkgd2FzIG1pc3Rha2VuIGFib3V0IHRoZSBhdXRo
ZW50aWNhdGlvbiBtZXRob2QgaW4gcHBwZCAtIGl0IGlzIHBhcMKgbm90wqBjaGFwLiBTbywgcHJv
YmFibHkgdGhpcyBpcyB0aGUgcHJvYmxlbS4gSG93IGNhbiBJIGNoYW5nZSB0aGUgYXV0aGVudGlj
YXRpb24gbWV0aG9kIGZvciB0aGUgY29udGV4dCBhY3RpdmF0aW9uIGluIE9mb25vIGZyb20gZGVm
YXVsdCBjaGFwIHRvIHBhcD8gV2hlcmUgaXMgdGhlIGJlc3QgcGxhY2UgdG8gZG8gaXQgaW4gdGhl
IGNvZGU/PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtc2l6ZTpz
bWFsbCI+PGJyPjwvZGl2PjxkaXY+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVy
ZSIgZGF0YS1zbWFydG1haWw9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdiBk
aXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRp
diBkaXI9Imx0ciI+PGRpdj48Zm9udCBmYWNlPSJhcmlhbCBuYXJyb3csIHNhbnMtc2VyaWYiPllv
dXJzIHNpbmNlcmVseSw8L2ZvbnQ+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6
JnF1b3Q7YXJpYWwgbmFycm93JnF1b3Q7LHNhbnMtc2VyaWYiPlNlcmdlacKgPC9zcGFuPjxmb250
IGZhY2U9ImFyaWFsIG5hcnJvdywgc2Fucy1zZXJpZiI+R29sdWJ0c292LjwvZm9udD48L2Rpdj48
L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PC9kaXY+
PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxf
YXR0ciI+T24gVHVlLCBEZWMgMjksIDIwMjAgYXQgMzowOSBQTSBTZXJnZWkgR29sdWJ0c292ICZs
dDs8YSBocmVmPSJtYWlsdG86cy5lLmdvbHVidHNvdkBnbWFpbC5jb20iPnMuZS5nb2x1YnRzb3ZA
Z21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHgg
c29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48
ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1zaXplOnNtYWxsIj5IZWxsbyw8
YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPjxkaXYgc3R5
bGU9ImZvbnQtc2l6ZTpzbWFsbCI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTpzbWFs
bCI+SSBhbSB0cnlpbmcgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZSA8c3BhbiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+PC9zcGFuPlF1ZWN0ZWwgRUMyMDBUIFVT
QiBtb2RlbS4gVGhpcyBtb2RlbSB1c2VzIHRoZSBvcHRpb24gVVNCIHNlcmlhbCBkcml2ZXIgaW4g
dGhlIGtlcm5lbC48L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6c21hbGwiPkFzIG90aGVyIFF1
ZWN0ZWwgbW9kZW1zLCB0aGlzIG9uZSB1c2VzIHRoZSBhdG1vZGVtwqBvZm9ubyBkcml2ZXIuwqA8
L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6c21hbGwiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJm
b250LXNpemU6c21hbGwiPkkgY2Fubm90IG92ZXJjb21lIHRoZSBwcm9ibGVtwqBvZiBjb250ZXh0
IGFjdGl2YXRpb24uIEl0IGZhaWxzIGF0ICZxdW90O29mb25vL2dhdGNoYXQvZ2F0cHBwLmM6cHBw
X2VudGVyX3BoYXNlKCkgMiZxdW90OyBhZnRlciBhIG1pbnV0ZS48L2Rpdj48ZGl2IHN0eWxlPSJm
b250LXNpemU6c21hbGwiPkF0IHRoZSBzYW1lIHRpbWUsIEkgY2FuIHN1Y2Nlc3NmdWxsecKgdXNl
IHBwcGQuIEJvdGggcHBwZCBhbmQgb2Zvbm8gdXNlIHRoZSBjaGFwIGF1dGhlbnRpY2F0aW9uIG1l
dGhvZC48L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6c21hbGwiPjxicj48L2Rpdj48ZGl2IHN0
eWxlPSJmb250LXNpemU6c21hbGwiPlBsZWFzZSBmaW5kIGxvZ3MgYW5kIHRoZSBwYXRjaCBhdHRh
Y2hlZC48L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6c21hbGwiPkFuecKgc3VnZ2VzdGlvbnMg
d2lsbCBiZSBhcHByZWNpYXRlZC48L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6c21hbGwiPjxi
cj48L2Rpdj48ZGl2PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIi
PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJs
dHIiPjxkaXY+PGZvbnQgZmFjZT0iYXJpYWwgbmFycm93LCBzYW5zLXNlcmlmIj5Zb3VycyBzaW5j
ZXJlbHksPC9mb250PjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O2Fy
aWFsIG5hcnJvdyZxdW90OyxzYW5zLXNlcmlmIj5TZXJnZWnCoDwvc3Bhbj48Zm9udCBmYWNlPSJh
cmlhbCBuYXJyb3csIHNhbnMtc2VyaWYiPkdvbHVidHNvdi48L2ZvbnQ+PC9kaXY+PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+CjwvZGl2PjwvZGl2
Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============5342411403066369900==--

