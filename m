Content-Type: multipart/mixed; boundary="===============1932250293139283517=="
MIME-Version: 1.0
From: Jason Tribe <jasontribe8@gmail.com>
Subject: Re: HE910-G - Can't activate context
Date: Fri, 29 Jun 2018 09:39:54 +0200
Message-ID: <CAGyX7WaQ9Nruh_-=6SjHTk8OcZAZQqVcpZAdc2LJb0q+7mV4fA@mail.gmail.com>
In-Reply-To: <fd742276-a2d3-28fc-1dd2-13a03b1bb278@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1932250293139283517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> The current problem we are having is that we cannot activate the context
>> with ofono or connman. Any attempt fails with:
>>
>> Error activating /telit_1/context1: org.ofono.Error.NotImplemented:
>> Implementation not provided.
>
> You might want to enable debugging (-d command line option) and see what
> it says.  HE910 uses the 'atmodem' gprs-context driver, which in turn
> depends on tun/tap being loaded.  Most likely your kernel is missing
> this functionality or you forgot to load the required module.

Thanks very much for the feedback. You were 100% correct, we did not have
TUN/TAP enabled in our kernel build.

Kind regards
Jason

On Sun, 24 Jun 2018 at 22:14, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Jason,
>
> > enable/power the modem through ofono and even register the SIM on the
> > network. From what I can tell, this bug seems to be present in all ofono
> > versions that don't use the he910.c plugin.
>
> Maybe just the newer firmware behaves differently.  I think the people
> who merged the various telit drivers were using LE/UE 910 which is a bit
> newer than the HE910.
>
> > The current problem we are having is that we cannot activate the context
> > with ofono or connman. Any attempt fails with:
> >
> > Error activating /telit_1/context1: org.ofono.Error.NotImplemented:
> > Implementation not provided.
>
> You might want to enable debugging (-d command line option) and see what
> it says.  HE910 uses the 'atmodem' gprs-context driver, which in turn
> depends on tun/tap being loaded.  Most likely your kernel is missing
> this functionality or you forgot to load the required module.
>
> Regards,
> -Denis
>

--===============1932250293139283517==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48c3BhbiBjbGFzcz0iZ21haWwtaW0iIHN0eWxlPSJ0ZXh0LWRl
Y29yYXRpb24tc3R5bGU6aW5pdGlhbDt0ZXh0LWRlY29yYXRpb24tY29sb3I6aW5pdGlhbCI+PGZv
bnQgY29sb3I9IiMwMDAwMDAiPkhpIERlbmlzLDwvZm9udD48L3NwYW4+PC9kaXY+PGRpdj48c3Bh
biBjbGFzcz0iZ21haWwtaW0iIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb24tc3R5bGU6aW5pdGlhbDt0
ZXh0LWRlY29yYXRpb24tY29sb3I6aW5pdGlhbCI+PGZvbnQgY29sb3I9IiMwMDAwMDAiPjxicj48
L2ZvbnQ+PC9zcGFuPjwvZGl2PgoKPGZvbnQgY29sb3I9IiMwMDAwMDAiPjxzcGFuIGNsYXNzPSJn
bWFpbC1pbSIgc3R5bGU9InRleHQtZGVjb3JhdGlvbi1zdHlsZTppbml0aWFsO3RleHQtZGVjb3Jh
dGlvbi1jb2xvcjppbml0aWFsIj4mZ3Q7Jmd0OyBUaGUgY3VycmVudCBwcm9ibGVtIHdlIGFyZSBo
YXZpbmcgaXMgdGhhdCB3ZSBjYW5ub3QgYWN0aXZhdGUgdGhlIGNvbnRleHQ8c3Bhbj7CoDwvc3Bh
bj48YnI+Jmd0OyZndDsgd2l0aCBvZm9ubyBvciBjb25ubWFuLiBBbnkgYXR0ZW1wdCBmYWlscyB3
aXRoOjxicj4mZ3Q7Jmd0Ozxicj4mZ3Q7Jmd0OyBFcnJvciBhY3RpdmF0aW5nIC90ZWxpdF8xL2Nv
bnRleHQxOiBvcmcub2Zvbm8uRXJyb3IuTm90SW1wbGVtZW50ZWQ6PHNwYW4+wqA8L3NwYW4+PGJy
PiZndDsmZ3Q7IEltcGxlbWVudGF0aW9uIG5vdCBwcm92aWRlZC48YnI+Jmd0Ozxicj48L3NwYW4+
PHNwYW4gc3R5bGU9InRleHQtZGVjb3JhdGlvbi1zdHlsZTppbml0aWFsO3RleHQtZGVjb3JhdGlv
bi1jb2xvcjppbml0aWFsO2Zsb2F0Om5vbmU7ZGlzcGxheTppbmxpbmUiPiZndDsgWW91IG1pZ2h0
IHdhbnQgdG8gZW5hYmxlIGRlYnVnZ2luZyAoLWQgY29tbWFuZCBsaW5lIG9wdGlvbikgYW5kIHNl
ZSB3aGF0PHNwYW4+wqA8L3NwYW4+PC9zcGFuPjxiciBzdHlsZT0idGV4dC1kZWNvcmF0aW9uLXN0
eWxlOmluaXRpYWw7dGV4dC1kZWNvcmF0aW9uLWNvbG9yOmluaXRpYWwiPjxzcGFuIHN0eWxlPSJ0
ZXh0LWRlY29yYXRpb24tc3R5bGU6aW5pdGlhbDt0ZXh0LWRlY29yYXRpb24tY29sb3I6aW5pdGlh
bDtmbG9hdDpub25lO2Rpc3BsYXk6aW5saW5lIj4mZ3Q7IGl0IHNheXMuwqAgSEU5MTAgdXNlcyB0
aGUgJiMzOTthdG1vZGVtJiMzOTsgZ3Bycy1jb250ZXh0IGRyaXZlciwgd2hpY2ggaW4gdHVybjxz
cGFuPsKgPC9zcGFuPjwvc3Bhbj48YnIgc3R5bGU9InRleHQtZGVjb3JhdGlvbi1zdHlsZTppbml0
aWFsO3RleHQtZGVjb3JhdGlvbi1jb2xvcjppbml0aWFsIj48c3BhbiBzdHlsZT0idGV4dC1kZWNv
cmF0aW9uLXN0eWxlOmluaXRpYWw7dGV4dC1kZWNvcmF0aW9uLWNvbG9yOmluaXRpYWw7ZmxvYXQ6
bm9uZTtkaXNwbGF5OmlubGluZSI+Jmd0OyBkZXBlbmRzIG9uIHR1bi90YXAgYmVpbmcgbG9hZGVk
LsKgIE1vc3QgbGlrZWx5IHlvdXIga2VybmVsIGlzIG1pc3Npbmc8c3Bhbj7CoDwvc3Bhbj48L3Nw
YW4+PGJyIHN0eWxlPSJ0ZXh0LWRlY29yYXRpb24tc3R5bGU6aW5pdGlhbDt0ZXh0LWRlY29yYXRp
b24tY29sb3I6aW5pdGlhbCI+PHNwYW4gc3R5bGU9InRleHQtZGVjb3JhdGlvbi1zdHlsZTppbml0
aWFsO3RleHQtZGVjb3JhdGlvbi1jb2xvcjppbml0aWFsO2Zsb2F0Om5vbmU7ZGlzcGxheTppbmxp
bmUiPiZndDsgdGhpcyBmdW5jdGlvbmFsaXR5IG9yIHlvdSBmb3Jnb3QgdG8gbG9hZCB0aGUgcmVx
dWlyZWQgbW9kdWxlLjwvc3Bhbj4KCjxicj48L2ZvbnQ+PGRpdj48Zm9udCBjb2xvcj0iIzAwMDAw
MCI+PGJyPjwvZm9udD48L2Rpdj48ZGl2Pjxmb250IGNvbG9yPSIjMDAwMDAwIj5UaGFua3MgdmVy
eSBtdWNoIGZvciB0aGUgZmVlZGJhY2suIFlvdSB3ZXJlIDEwMCUgY29ycmVjdCwgd2UgZGlkIG5v
dCBoYXZlIFRVTi9UQVAgZW5hYmxlZCBpbiBvdXIga2VybmVsIGJ1aWxkLjwvZm9udD48L2Rpdj48
ZGl2Pjxmb250IGNvbG9yPSIjMDAwMDAwIj48YnI+PC9mb250PjwvZGl2PjxkaXY+PGZvbnQgY29s
b3I9IiMwMDAwMDAiPktpbmQgcmVnYXJkczwvZm9udD48L2Rpdj48ZGl2Pjxmb250IGNvbG9yPSIj
MDAwMDAwIj5KYXNvbjwvZm9udD48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVv
dGUiPjxkaXYgZGlyPSJsdHIiPk9uIFN1biwgMjQgSnVuIDIwMTggYXQgMjI6MTQsIERlbmlzIEtl
bnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFp
bC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7
cGFkZGluZy1sZWZ0OjFleCI+SGkgSmFzb24sPGJyPgo8YnI+CiZndDsgZW5hYmxlL3Bvd2VyIHRo
ZSBtb2RlbSB0aHJvdWdoIG9mb25vIGFuZCBldmVuIHJlZ2lzdGVyIHRoZSBTSU0gb24gdGhlIDxi
cj4KJmd0OyBuZXR3b3JrLiBGcm9tIHdoYXQgSSBjYW4gdGVsbCwgdGhpcyBidWcgc2VlbXMgdG8g
YmUgcHJlc2VudCBpbiBhbGwgb2Zvbm8gPGJyPgomZ3Q7IHZlcnNpb25zIHRoYXQgZG9uJiMzOTt0
IHVzZSB0aGUgaGU5MTAuYyBwbHVnaW4uPGJyPgo8YnI+Ck1heWJlIGp1c3QgdGhlIG5ld2VyIGZp
cm13YXJlIGJlaGF2ZXMgZGlmZmVyZW50bHkuwqAgSSB0aGluayB0aGUgcGVvcGxlIDxicj4Kd2hv
IG1lcmdlZCB0aGUgdmFyaW91cyB0ZWxpdCBkcml2ZXJzIHdlcmUgdXNpbmcgTEUvVUUgOTEwIHdo
aWNoIGlzIGEgYml0IDxicj4KbmV3ZXIgdGhhbiB0aGUgSEU5MTAuPGJyPgo8YnI+CiZndDsgVGhl
IGN1cnJlbnQgcHJvYmxlbSB3ZSBhcmUgaGF2aW5nIGlzIHRoYXQgd2UgY2Fubm90IGFjdGl2YXRl
IHRoZSBjb250ZXh0IDxicj4KJmd0OyB3aXRoIG9mb25vIG9yIGNvbm5tYW4uIEFueSBhdHRlbXB0
IGZhaWxzIHdpdGg6PGJyPgomZ3Q7IDxicj4KJmd0OyBFcnJvciBhY3RpdmF0aW5nIC90ZWxpdF8x
L2NvbnRleHQxOiBvcmcub2Zvbm8uRXJyb3IuTm90SW1wbGVtZW50ZWQ6IDxicj4KJmd0OyBJbXBs
ZW1lbnRhdGlvbiBub3QgcHJvdmlkZWQuPGJyPgo8YnI+CllvdSBtaWdodCB3YW50IHRvIGVuYWJs
ZSBkZWJ1Z2dpbmcgKC1kIGNvbW1hbmQgbGluZSBvcHRpb24pIGFuZCBzZWUgd2hhdCA8YnI+Cml0
IHNheXMuwqAgSEU5MTAgdXNlcyB0aGUgJiMzOTthdG1vZGVtJiMzOTsgZ3Bycy1jb250ZXh0IGRy
aXZlciwgd2hpY2ggaW4gdHVybiA8YnI+CmRlcGVuZHMgb24gdHVuL3RhcCBiZWluZyBsb2FkZWQu
wqAgTW9zdCBsaWtlbHkgeW91ciBrZXJuZWwgaXMgbWlzc2luZyA8YnI+CnRoaXMgZnVuY3Rpb25h
bGl0eSBvciB5b3UgZm9yZ290IHRvIGxvYWQgdGhlIHJlcXVpcmVkIG1vZHVsZS48YnI+Cjxicj4K
UmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============1932250293139283517==--

