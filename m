Content-Type: multipart/mixed; boundary="===============0806780139800768184=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Re: [RFC 7/7] doc: Add new property to call forwarding
Date: Fri, 26 Nov 2010 12:01:04 +0530
Message-ID: <AANLkTi=GFwQUxCD5uFdwZsQvfTk0h6hUO-6oSZhS_akK@mail.gmail.com>
In-Reply-To: <1290752617-19024-8-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0806780139800768184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,



On Fri, Nov 26, 2010 at 11:53 AM, Jeevaka Badrappan <
jeevaka.badrappan@elektrobit.com> wrote:

> ---
>  doc/call-forwarding-api.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/doc/call-forwarding-api.txt b/doc/call-forwarding-api.txt
> index 067531a..5dfb48e 100644
> --- a/doc/call-forwarding-api.txt
> +++ b/doc/call-forwarding-api.txt
> @@ -57,3 +57,8 @@ Properties    string VoiceUnconditional [readwrite]
>
>                        Contains the value of the voice "Not Reachable" ca=
ll
>                        forwarding rule.
> +
> +               boolean VoiceUnconditionalStatus [readonly]
> +
> +                       Boolean representing the voice unconditional call
> +                       forwarding rule status.
>

As per the specification, querying of group of supplementary services is not
allowed. Do you propose a solution where core queries all the three call
forwardings namely CF busy, CF Not Reachable, CF noreply and updating the
clients with the status using the above property after receiving the status
for all the three?

> --
> 1.7.0.4
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============0806780139800768184==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgSmVldmFrYSw8ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPk9uIEZyaSwgTm92IDI2LCAyMDEwIGF0IDExOjUzIEFNLCBKZWV2YWthIEJhZHJhcHBh
biA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpqZWV2YWthLmJhZHJhcHBhbkBl
bGVrdHJvYml0LmNvbSI+amVldmFrYS5iYWRyYXBwYW5AZWxla3Ryb2JpdC5jb208L2E+Jmd0Ozwv
c3Bhbj4gd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4OyI+LS0tPGJyPgqgZG9jL2NhbGwtZm9yd2FyZGluZy1hcGkudHh0IHwgoCCgNSArKysrKzxi
cj4KoDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKTxicj4K
PGJyPgpkaWZmIC0tZ2l0IGEvZG9jL2NhbGwtZm9yd2FyZGluZy1hcGkudHh0IGIvZG9jL2NhbGwt
Zm9yd2FyZGluZy1hcGkudHh0PGJyPgppbmRleCAwNjc1MzFhLi41ZGZiNDhlIDEwMDY0NDxicj4K
LS0tIGEvZG9jL2NhbGwtZm9yd2FyZGluZy1hcGkudHh0PGJyPgorKysgYi9kb2MvY2FsbC1mb3J3
YXJkaW5nLWFwaS50eHQ8YnI+CkBAIC01NywzICs1Nyw4IEBAIFByb3BlcnRpZXMgoCCgc3RyaW5n
IFZvaWNlVW5jb25kaXRpb25hbCBbcmVhZHdyaXRlXTxicj4KPGJyPgogoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKBDb250YWlucyB0aGUgdmFsdWUgb2YgdGhlIHZvaWNlICZxdW90O05vdCBSZWFjaGFi
bGUmcXVvdDsgY2FsbDxicj4KIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgZm9yd2FyZGluZyBydWxl
Ljxicj4KKzxicj4KKyCgIKAgoCCgIKAgoCCgIGJvb2xlYW4gVm9pY2VVbmNvbmRpdGlvbmFsU3Rh
dHVzIFtyZWFkb25seV08YnI+Cis8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIEJvb2xlYW4g
cmVwcmVzZW50aW5nIHRoZSB2b2ljZSB1bmNvbmRpdGlvbmFsIGNhbGw8YnI+CisgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIGZvcndhcmRpbmcgcnVsZSBzdGF0dXMuPGJyPjwvYmxvY2txdW90ZT48ZGl2
Pjxicj48L2Rpdj48ZGl2PkFzIHBlciB0aGUgc3BlY2lmaWNhdGlvbiwgcXVlcnlpbmcgb2YgZ3Jv
dXAgb2Ygc3VwcGxlbWVudGFyeSBzZXJ2aWNlcyBpcyBub3QgYWxsb3dlZC4gRG8geW91IHByb3Bv
c2UgYSBzb2x1dGlvbiB3aGVyZSBjb3JlIHF1ZXJpZXMgYWxsIHRoZSB0aHJlZSBjYWxsIGZvcndh
cmRpbmdzIG5hbWVseSBDRiBidXN5LCBDRiBOb3QgUmVhY2hhYmxlLCBDRiBub3JlcGx5IGFuZCB1
cGRhdGluZyB0aGUgY2xpZW50cyB3aXRoIHRoZSBzdGF0dXMgdXNpbmcgdGhlIGFib3ZlIHByb3Bl
cnR5IGFmdGVyIHJlY2VpdmluZyB0aGUgc3RhdHVzIGZvciBhbGwgdGhlIHRocmVlP6A8L2Rpdj4K
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPgo8Zm9udCBjb2xv
cj0iIzg4ODg4OCI+LS08YnI+CjEuNy4wLjQ8YnI+Cjxicj4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEg
aHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEg
aHJlZj0iaHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubyIgdGFyZ2V0PSJfYmxh
bmsiPmh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8L2ZvbnQ+
PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4K

--===============0806780139800768184==--

