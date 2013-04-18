Content-Type: multipart/mixed; boundary="===============1372272789685335377=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: Re: [PATCH v3 3/7] hfp_ag_bluez5: Remove fd from hash when disconnect
Date: Thu, 18 Apr 2013 16:57:36 -0300
Message-ID: <CAG7KCRGaU899mU2rJYsFpt-gwkqciiEoQZDv_SnfQAtLYfWO4A@mail.gmail.com>
In-Reply-To: <516FFABF.8020706@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1372272789685335377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Apr 18, 2013 at 10:53 AM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Paulo,
>
>
> On 04/15/2013 04:41 PM, Paulo Borges wrote:
>
>> [...]
>
>
> Actually you need to call shutdown() on it.  When multiple references to
> the file descriptor exist, close() simply deletes a reference.  It does n=
ot
> close the actual socket.
>
> [...]
>
>
> Overall I like this approach much better than the previous one.  I'd still
> re-arrange the patch set as follows:
>
> - init/free hash table (same as patch 1)
> - G_IO_HUP changes
> - RequestDisconnect implementation
>
>
Ok, I'll re-send this patches soon.

-- =

Cheers,
Paulo.

--===============1372272789685335377==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+
PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIFRodSwgQXByIDE4LCAyMDEzIGF0IDEwOjUzIEFN
LCBEZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtl
bnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwv
c3Bhbj4gd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij5IaSBQYXVsbyw8ZGl2IGNsYXNzPSJpbSI+PGJyPgo8YnI+Ck9uIDA0LzE1LzIwMTMgMDQ6
NDEgUE0sIFBhdWxvIEJvcmdlcyB3cm90ZTo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPlsuLi5dCjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PgpBY3R1YWxs
eSB5b3UgbmVlZCB0byBjYWxsIHNodXRkb3duKCkgb24gaXQuIKBXaGVuIG11bHRpcGxlIHJlZmVy
ZW5jZXMgdG8gdGhlIGZpbGUgZGVzY3JpcHRvciBleGlzdCwgY2xvc2UoKSBzaW1wbHkgZGVsZXRl
cyBhIHJlZmVyZW5jZS4goEl0IGRvZXMgbm90IGNsb3NlIHRoZSBhY3R1YWwgc29ja2V0LjxkaXYg
Y2xhc3M9ImltIj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+ClsuLi5dCjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PgpPdmVyYWxsIEkgbGlrZSB0aGlzIGFw
cHJvYWNoIG11Y2ggYmV0dGVyIHRoYW4gdGhlIHByZXZpb3VzIG9uZS4goEkmIzM5O2Qgc3RpbGwg
cmUtYXJyYW5nZSB0aGUgcGF0Y2ggc2V0IGFzIGZvbGxvd3M6PGJyPgo8YnI+Ci0gaW5pdC9mcmVl
IGhhc2ggdGFibGUgKHNhbWUgYXMgcGF0Y2ggMSk8YnI+Ci0gR19JT19IVVAgY2hhbmdlczxicj4K
LSBSZXF1ZXN0RGlzY29ubmVjdCBpbXBsZW1lbnRhdGlvbjxkaXYgY2xhc3M9ImltIj48YnI+PC9k
aXY+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+T2ssIEkmIzM5O2xsIHJlLXNlbmQgdGhpcyBwYXRj
aGVzIHNvb24uPGJyIGNsZWFyPSJhbGwiPjxkaXY+PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGRpcj0i
bHRyIj5DaGVlcnMsPGRpdiBzdHlsZT5QYXVsby48L2Rpdj48L2Rpdj4KPC9kaXY+PC9kaXY+Cg==

--===============1372272789685335377==--

