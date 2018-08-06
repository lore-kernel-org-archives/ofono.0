Content-Type: multipart/mixed; boundary="===============8064236226737764158=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: atmodem driver cnmi
Date: Mon, 06 Aug 2018 18:49:15 +0200
Message-ID: <CAKSBH7Gjx9hvzJ-60vCa2RmXA=AyEdcj_HxmnVs_CeYFyeTWCA@mail.gmail.com>
In-Reply-To: <41ede655-1e8b-d514-b5b2-0875e888bba2@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8064236226737764158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thank you for the clarification.

now I went through the code again and it is clearer.

Regards,
Giacinto


On Mon, Aug 6, 2018 at 6:37 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> On 08/06/2018 11:33 AM, Giacinto Cifelli wrote:
> > Dear all,
> >
> > I have a question for the function build_cnmi_string() in
> > plugins/atmodem/sms.c
> >
> > The numeric values appear corrupted, like "2310" instead of "2".
> >
> > example, from an excerpt:
> > `default:
> > /* Sounds like 2 is the sanest mode */
> > mode =3D "2310";
> > break;
> > `
> >
> > Am I missing something, like a post-processing, or some specific
>
> Yes, you're missing the fact that append_cnmi_element uses wanted_cnmi,
> which selects the 'best' cnmi mode based on the reported modem capability.
>
> > implementation not compliant with the 3GPP TS_27.005, or there is a
> > problem with this function?
> >
>
> Regards,
> -Denis
>

--===============8064236226737764158==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj5UaGFuayB5
b3UgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLsKgPGJyPjxkaXY+PGJyPjwvZGl2PjxkaXY+bm93IEkg
d2VudCB0aHJvdWdoIHRoZSBjb2RlIGFnYWluIGFuZCBpdCBpcyBjbGVhcmVyLjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8L2Rpdj48ZGl2PkdpYWNpbnRvPC9kaXY+PGRpdj48YnI+
PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5P
biBNb24sIEF1ZyA2LCAyMDE4IGF0IDY6MzcgUE0gRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3Rl
Ojxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5I
aSBHaWFjaW50byw8YnI+Cjxicj4KT24gMDgvMDYvMjAxOCAxMTozMyBBTSwgR2lhY2ludG8gQ2lm
ZWxsaSB3cm90ZTo8YnI+CiZndDsgRGVhciBhbGwsPGJyPgomZ3Q7IDxicj4KJmd0OyBJIGhhdmUg
YSBxdWVzdGlvbiBmb3IgdGhlIGZ1bmN0aW9uIGJ1aWxkX2NubWlfc3RyaW5nKCkgaW4gPGJyPgom
Z3Q7IHBsdWdpbnMvYXRtb2RlbS9zbXMuYzxicj4KJmd0OyA8YnI+CiZndDsgVGhlIG51bWVyaWMg
dmFsdWVzIGFwcGVhciBjb3JydXB0ZWQsIGxpa2UgJnF1b3Q7MjMxMCZxdW90OyBpbnN0ZWFkIG9m
ICZxdW90OzImcXVvdDsuPGJyPgomZ3Q7IDxicj4KJmd0OyBleGFtcGxlLCBmcm9tIGFuIGV4Y2Vy
cHQ6PGJyPgomZ3Q7IGBkZWZhdWx0Ojxicj4KJmd0OyAvKiBTb3VuZHMgbGlrZSAyIGlzIHRoZSBz
YW5lc3QgbW9kZSAqLzxicj4KJmd0OyBtb2RlID0gJnF1b3Q7MjMxMCZxdW90Ozs8YnI+CiZndDsg
YnJlYWs7PGJyPgomZ3Q7IGA8YnI+CiZndDsgPGJyPgomZ3Q7IEFtIEkgbWlzc2luZyBzb21ldGhp
bmcsIGxpa2UgYSBwb3N0LXByb2Nlc3NpbmcsIG9yIHNvbWUgc3BlY2lmaWMgPGJyPgo8YnI+Clll
cywgeW91JiMzOTtyZSBtaXNzaW5nIHRoZSBmYWN0IHRoYXQgYXBwZW5kX2NubWlfZWxlbWVudCB1
c2VzIHdhbnRlZF9jbm1pLCA8YnI+CndoaWNoIHNlbGVjdHMgdGhlICYjMzk7YmVzdCYjMzk7IGNu
bWkgbW9kZSBiYXNlZCBvbiB0aGUgcmVwb3J0ZWQgbW9kZW0gY2FwYWJpbGl0eS48YnI+Cjxicj4K
Jmd0OyBpbXBsZW1lbnRhdGlvbiBub3QgY29tcGxpYW50IHdpdGggdGhlIDNHUFAgVFNfMjcuMDA1
LCBvciB0aGVyZSBpcyBhIDxicj4KJmd0OyBwcm9ibGVtIHdpdGggdGhpcyBmdW5jdGlvbj88YnI+
CiZndDsgPGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+CjwvYmxvY2txdW90ZT48L2Rp
dj4K

--===============8064236226737764158==--

