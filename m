Content-Type: multipart/mixed; boundary="===============7067616937541223975=="
MIME-Version: 1.0
From: Freedreamer <freedreamer@email.it>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Fri, 29 Mar 2013 12:24:49 +0100
Message-ID: <CAAs3wMiz-gTvWp4ZU3X1aJ25TLViKdirqQ3BQJiJC=hWoLN3tw@mail.gmail.com>
In-Reply-To: <51549CEF.3070906@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7067616937541223975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2013/3/28 Denis Kenzior <denkenz@gmail.com>

> Hi,
>
>
>  Hi ,
>> got new information. I start gdb and backtrace and i found where is the
>> seg fault. The function "decode_at_error"  doesn't check if *error or
>> *final are NULL... and in my case they are.
>> if  I put a check in the function it remains stuck waiting AT cmd
>> reply....
>>
>>
> The wakeup logic should only be used with the Freerunner.  Please disable
> it unless you know what you're doing.  Something else is wrong.
>
> Regards,
> -Denis
>

Denis u were right... removing wakeup cmd it seems it works again also on
the embedded board.Now i will work on ppp and connman integration.

Thanks

--===============7067616937541223975==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMy8zLzI4IERlbmlzIEtlbnpp
b3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20i
IHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjxicj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3Jk
ZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KSGksPGRpdiBjbGFzcz0i
aW0iPjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij4KSGkgLDxicj4KZ290IG5ldyBpbmZvcm1hdGlvbi4gSSBzdGFydCBnZGIgYW5kIGJhY2t0cmFj
ZSBhbmQgaSBmb3VuZCB3aGVyZSBpcyB0aGU8YnI+CnNlZyBmYXVsdC4gVGhlIGZ1bmN0aW9uICZx
dW90O2RlY29kZV9hdF9lcnJvciZxdW90OyCgZG9lc24mIzM5O3QgY2hlY2sgaWYgKmVycm9yIG9y
PGJyPgoqZmluYWwgYXJlIE5VTEwuLi4gYW5kIGluIG15IGNhc2UgdGhleSBhcmUuPGJyPgppZiCg
SSBwdXQgYSBjaGVjayBpbiB0aGUgZnVuY3Rpb24gaXQgcmVtYWlucyBzdHVjayB3YWl0aW5nIEFU
IGNtZCByZXBseS4uLi48YnI+Cjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9kaXY+ClRoZSB3YWtl
dXAgbG9naWMgc2hvdWxkIG9ubHkgYmUgdXNlZCB3aXRoIHRoZSBGcmVlcnVubmVyLiCgUGxlYXNl
IGRpc2FibGUgaXQgdW5sZXNzIHlvdSBrbm93IHdoYXQgeW91JiMzOTtyZSBkb2luZy4goFNvbWV0
aGluZyBlbHNlIGlzIHdyb25nLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Js
b2NrcXVvdGU+PC9kaXY+PGJyPkRlbmlzIHUgd2VyZSByaWdodC4uLiByZW1vdmluZyB3YWtldXAg
Y21kIGl0IHNlZW1zIGl0IHdvcmtzIGFnYWluIGFsc28gb24gdGhlIGVtYmVkZGVkIGJvYXJkLk5v
dyBpIHdpbGwgd29yayBvbiBwcHAgYW5kIGNvbm5tYW4gaW50ZWdyYXRpb24uIDxicj48YnI+VGhh
bmtzIDxicj4K

--===============7067616937541223975==--

