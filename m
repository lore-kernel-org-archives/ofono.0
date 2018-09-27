Content-Type: multipart/mixed; boundary="===============1762001182268779508=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: status
Date: Thu, 27 Sep 2018 19:59:14 +0200
Message-ID: <CAKSBH7GzLZrpYvALMr8iRHrc7+wQUKbrgcgV-+hPUpcFNxeMbg@mail.gmail.com>
In-Reply-To: <aa0f22dd-bf16-1f57-a4fc-a9b7261dbc2b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1762001182268779508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

thank you for answering on all points, now I have some feedback for
improvement.

On Thu, Sep 27, 2018 at 6:52 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> > For the gemaltomodem/gprs-context, it is not clear how to proceed. Would
> > you kindly give some suggestion other than "these modules don't exist in
> > my world"?
>
> I did give you a suggestion on how to proceed.  Lets get the sane ones
> supported first.  That should be mostly easy.
>
> For the insane ones we will need to figure something else out.  For
> example, it may be that we should just have oFono initiate the DHCP
> request itself for these devices.  The driver can then control both DHCP
> and context activation status and would be able to sanely tell the core
> what is going on.  We already have DHCP code available in ConnMan that
> could be ported to oFono, or more likely finish DHCP support in ell and
> use that.
>
> Maybe there are simpler / better approaches that could be tried as well.
>   But the current proposal for these insane devices is just not going to
> work.
>

Now that you are offering some perspective, even if it is undeniably a lot
of work (and discussion), I agree on starting on the normal cases first.


Regards,
> -Denis
>

Regards,
Giacinto

--===============1762001182268779508==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGJyPjxicj50aGFuayB5b3UgZm9yIGFuc3dlcmluZyBv
biBhbGwgcG9pbnRzLCBub3cgSSBoYXZlIHNvbWUgZmVlZGJhY2sgZm9yIGltcHJvdmVtZW50Ljxi
cj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgU2Vw
IDI3LCAyMDE4IGF0IDY6NTIgUE0gRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRl
bmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rp
dj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhl
eDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBHaWFjaW50
byw8YnI+Cjxicj4KJmd0OyBGb3IgdGhlIGdlbWFsdG9tb2RlbS9ncHJzLWNvbnRleHQsIGl0IGlz
IG5vdCBjbGVhciBob3cgdG8gcHJvY2VlZC4gV291bGQ8YnI+CiZndDsgeW91IGtpbmRseSBnaXZl
IHNvbWUgc3VnZ2VzdGlvbiBvdGhlciB0aGFuICZxdW90O3RoZXNlIG1vZHVsZXMgZG9uJiMzOTt0
IGV4aXN0IGluIDxicj4KJmd0OyBteSB3b3JsZCZxdW90Oz88YnI+Cjxicj4KSSBkaWQgZ2l2ZSB5
b3UgYSBzdWdnZXN0aW9uIG9uIGhvdyB0byBwcm9jZWVkLsKgIExldHMgZ2V0IHRoZSBzYW5lIG9u
ZXMgPGJyPgpzdXBwb3J0ZWQgZmlyc3QuwqAgVGhhdCBzaG91bGQgYmUgbW9zdGx5IGVhc3kuPGJy
Pgo8YnI+CkZvciB0aGUgaW5zYW5lIG9uZXMgd2Ugd2lsbCBuZWVkIHRvIGZpZ3VyZSBzb21ldGhp
bmcgZWxzZSBvdXQuwqAgRm9yIDxicj4KZXhhbXBsZSwgaXQgbWF5IGJlIHRoYXQgd2Ugc2hvdWxk
IGp1c3QgaGF2ZSBvRm9ubyBpbml0aWF0ZSB0aGUgREhDUCA8YnI+CnJlcXVlc3QgaXRzZWxmIGZv
ciB0aGVzZSBkZXZpY2VzLsKgIFRoZSBkcml2ZXIgY2FuIHRoZW4gY29udHJvbCBib3RoIERIQ1Ag
PGJyPgphbmQgY29udGV4dCBhY3RpdmF0aW9uIHN0YXR1cyBhbmQgd291bGQgYmUgYWJsZSB0byBz
YW5lbHkgdGVsbCB0aGUgY29yZSA8YnI+CndoYXQgaXMgZ29pbmcgb24uwqAgV2UgYWxyZWFkeSBo
YXZlIERIQ1AgY29kZSBhdmFpbGFibGUgaW4gQ29ubk1hbiB0aGF0IDxicj4KY291bGQgYmUgcG9y
dGVkIHRvIG9Gb25vLCBvciBtb3JlIGxpa2VseSBmaW5pc2ggREhDUCBzdXBwb3J0IGluIGVsbCBh
bmQgPGJyPgp1c2UgdGhhdC48YnI+Cjxicj4KTWF5YmUgdGhlcmUgYXJlIHNpbXBsZXIgLyBiZXR0
ZXIgYXBwcm9hY2hlcyB0aGF0IGNvdWxkIGJlIHRyaWVkIGFzIHdlbGwuIDxicj4KwqAgQnV0IHRo
ZSBjdXJyZW50IHByb3Bvc2FsIGZvciB0aGVzZSBpbnNhbmUgZGV2aWNlcyBpcyBqdXN0IG5vdCBn
b2luZyB0byA8YnI+CndvcmsuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pk5v
dyB0aGF0IHlvdSBhcmUgb2ZmZXJpbmcgc29tZSBwZXJzcGVjdGl2ZSwgZXZlbiBpZiBpdCBpcyB1
bmRlbmlhYmx5IGEgbG90IG9mIHdvcmsgKGFuZCBkaXNjdXNzaW9uKSwgSSBhZ3JlZSBvbiBzdGFy
dGluZyBvbiB0aGUgbm9ybWFsIGNhc2VzIGZpcnN0LjwvZGl2PjxkaXY+wqA8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAw
IDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KUmVn
YXJkcyw8YnI+Ci1EZW5pczxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdh
cmRzLDwvZGl2PjxkaXY+R2lhY2ludG88L2Rpdj48ZGl2PsKgPC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============1762001182268779508==--

