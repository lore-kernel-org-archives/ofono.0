Content-Type: multipart/mixed; boundary="===============3304057014270184395=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Re: Adding New contact failed in Ofono
Date: Tue, 17 May 2011 11:24:22 +0530
Message-ID: <BANLkTi=4FuTTL1=Jw=+C2KSy+O07xCkh8w@mail.gmail.com>
In-Reply-To: <4DD08B77.6050505@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3304057014270184395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your reply.


Suppose end user wants to store his/her contact number in SIM. What is the
way to do?

Actually all mobile devices supporting these features. ( Personally i feel
that very end user expecting these feature).

I don't know ,there could some technical reasons

Please correct me. If my understanding is wrong


Thanks

Yuvi R


On Mon, May 16, 2011 at 7:57 AM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Yuvi,
>
> On 05/16/2011 02:28 AM, Yuvaraj Ragupathi wrote:
> > Hi All,
> >
> > I am trying to add new contact in sim via following sample code
> >
> >
> > static  int new_contact(struct ofono_phonebook *pb,char
> > *num,ofono_phonebook_cb_t cb)
> > {
> >     struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
> >     char cmd[50];int return_value;
> >         sprintf(cmd,"AT+CPBW=3D10,%s,129,Testing", num);
> >         printf("Command is %s\n",cmd);
> >     return_value=3Dg_at_chat_send(pbd->chat,cmd, none_prefix,
> >                        NULL,NULL, NULL);
> >         printf("Add New contact number in Sim\n Status is
> > %d\n",return_value);
> >         return return_value;
> > }
> >
>
> oFono core does not support adding new contacts to the sim and there are
> no plans to do so.  So I'm not quite sure what you're trying to
> accomplish here in the first place.  If your question is about using
> GAtChat, then adjust your subject accordingly.
>
> >
> > If i try to add new contact  my Return status is  69 or 70
> >
>
> Your 'return status' is just an ID assigned by GAtChat.  GAtChat is
> _asynchronous_, your command has not been executed yet.  If you want to
> know the result of the operation, provide a proper callback, or at the
> very least enable AT debug logging.  See HACKING for details.
>
> Regards,
> -Denis
>

--===============3304057014270184395==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj5UaGFua3MgZm9yIHlvdXIgcmVwbHkuPGJyPjxicj48YnI+U3VwcG9zZSBlbmQg
dXNlciB3YW50cyB0byBzdG9yZSBoaXMvaGVyIGNvbnRhY3QgbnVtYmVyIGluIFNJTS4gV2hhdCBp
cyB0aGUgd2F5IHRvIGRvPzxicj48YnI+QWN0dWFsbHkgYWxsIG1vYmlsZSBkZXZpY2VzIHN1cHBv
cnRpbmcgdGhlc2UgZmVhdHVyZXMuICggUGVyc29uYWxseSBpIGZlZWwgdGhhdCB2ZXJ5IGVuZCB1
c2VyIGV4cGVjdGluZyB0aGVzZSBmZWF0dXJlKS48YnI+Cjxicj5JIGRvbiYjMzk7dCBrbm93ICx0
aGVyZSBjb3VsZCBzb21lIHRlY2huaWNhbCByZWFzb25zPGJyPjxicj5QbGVhc2UgY29ycmVjdCBt
ZS4gSWYgbXkgdW5kZXJzdGFuZGluZyBpcyB3cm9uZzxicj48YnI+PGJyPlRoYW5rczxicj48YnI+
WXV2aSBSPGJyPjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgTWF5IDE2
LCAyMDExIGF0IDc6NTcgQU0sIERlbmlzIEtlbnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBo
cmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs8
L3NwYW4+IHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0
LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+SGkgWXV2aSw8YnI+CjxkaXYgY2xhc3M9
ImltIj48YnI+Ck9uIDA1LzE2LzIwMTEgMDI6MjggQU0sIFl1dmFyYWogUmFndXBhdGhpIHdyb3Rl
Ojxicj4KJmd0OyBIaSBBbGwsPGJyPgomZ3Q7PGJyPgomZ3Q7IEkgYW0gdHJ5aW5nIHRvIGFkZCBu
ZXcgY29udGFjdCBpbiBzaW0gdmlhIGZvbGxvd2luZyBzYW1wbGUgY29kZTxicj4KJmd0Ozxicj4K
Jmd0Ozxicj4KJmd0OyBzdGF0aWMgoGludCBuZXdfY29udGFjdChzdHJ1Y3Qgb2Zvbm9fcGhvbmVi
b29rICpwYixjaGFyPGJyPgomZ3Q7ICpudW0sb2Zvbm9fcGhvbmVib29rX2NiX3QgY2IpPGJyPgom
Z3Q7IHs8YnI+CiZndDsgoCCgIHN0cnVjdCBwYl9kYXRhICpwYmQgPSBvZm9ub19waG9uZWJvb2tf
Z2V0X2RhdGEocGIpOzxicj4KJmd0OyCgIKAgY2hhciBjbWRbNTBdO2ludCByZXR1cm5fdmFsdWU7
PGJyPgomZ3Q7IKAgoCCgIKAgc3ByaW50ZihjbWQsJnF1b3Q7QVQrQ1BCVz0xMCwlcywxMjksVGVz
dGluZyZxdW90OywgbnVtKTs8YnI+CiZndDsgoCCgIKAgoCBwcmludGYoJnF1b3Q7Q29tbWFuZCBp
cyAlc1xuJnF1b3Q7LGNtZCk7PGJyPgomZ3Q7IKAgoCByZXR1cm5fdmFsdWU9Z19hdF9jaGF0X3Nl
bmQocGJkLSZndDtjaGF0LGNtZCwgbm9uZV9wcmVmaXgsPGJyPgomZ3Q7IKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgTlVMTCxOVUxMLCBOVUxMKTs8YnI+CiZndDsgoCCgIKAgoCBwcmludGYoJnF1b3Q7
QWRkIE5ldyBjb250YWN0IG51bWJlciBpbiBTaW1cbiBTdGF0dXMgaXM8YnI+CiZndDsgJWRcbiZx
dW90OyxyZXR1cm5fdmFsdWUpOzxicj4KJmd0OyCgIKAgoCCgIHJldHVybiByZXR1cm5fdmFsdWU7
PGJyPgomZ3Q7IH08YnI+CiZndDs8YnI+Cjxicj4KPC9kaXY+b0Zvbm8gY29yZSBkb2VzIG5vdCBz
dXBwb3J0IGFkZGluZyBuZXcgY29udGFjdHMgdG8gdGhlIHNpbSBhbmQgdGhlcmUgYXJlPGJyPgpu
byBwbGFucyB0byBkbyBzby4goFNvIEkmIzM5O20gbm90IHF1aXRlIHN1cmUgd2hhdCB5b3UmIzM5
O3JlIHRyeWluZyB0bzxicj4KYWNjb21wbGlzaCBoZXJlIGluIHRoZSBmaXJzdCBwbGFjZS4goElm
IHlvdXIgcXVlc3Rpb24gaXMgYWJvdXQgdXNpbmc8YnI+CkdBdENoYXQsIHRoZW4gYWRqdXN0IHlv
dXIgc3ViamVjdCBhY2NvcmRpbmdseS48YnI+CjxkaXYgY2xhc3M9ImltIj48YnI+CiZndDs8YnI+
CiZndDsgSWYgaSB0cnkgdG8gYWRkIG5ldyBjb250YWN0IKBteSBSZXR1cm4gc3RhdHVzIGlzIKA2
OSBvciA3MDxicj4KJmd0Ozxicj4KPGJyPgo8L2Rpdj5Zb3VyICYjMzk7cmV0dXJuIHN0YXR1cyYj
Mzk7IGlzIGp1c3QgYW4gSUQgYXNzaWduZWQgYnkgR0F0Q2hhdC4goEdBdENoYXQgaXM8YnI+Cl9h
c3luY2hyb25vdXNfLCB5b3VyIGNvbW1hbmQgaGFzIG5vdCBiZWVuIGV4ZWN1dGVkIHlldC4goElm
IHlvdSB3YW50IHRvPGJyPgprbm93IHRoZSByZXN1bHQgb2YgdGhlIG9wZXJhdGlvbiwgcHJvdmlk
ZSBhIHByb3BlciBjYWxsYmFjaywgb3IgYXQgdGhlPGJyPgp2ZXJ5IGxlYXN0IGVuYWJsZSBBVCBk
ZWJ1ZyBsb2dnaW5nLiCgU2VlIEhBQ0tJTkcgZm9yIGRldGFpbHMuPGJyPgo8YnI+ClJlZ2FyZHMs
PGJyPgo8Zm9udCBjb2xvcj0iIzg4ODg4OCI+LURlbmlzPGJyPgo8L2ZvbnQ+PC9ibG9ja3F1b3Rl
PjwvZGl2Pjxicj4K

--===============3304057014270184395==--

