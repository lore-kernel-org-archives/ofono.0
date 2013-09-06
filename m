Content-Type: multipart/mixed; boundary="===============6324745338543374386=="
MIME-Version: 1.0
From: Etienne Mabille <mabille.etienne@gmail.com>
Subject: Re: Telit HE910 initialisation sequence freezes
Date: Fri, 06 Sep 2013 17:34:30 +0200
Message-ID: <CAMtf1D8D76kk5yfoS26JhZGNg=C89a1xfHa6tbLn0-MkwWdqsg@mail.gmail.com>
In-Reply-To: <522969B4.8050806@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6324745338543374386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

I don't know exactly what firmware version we are using today. I know
however that we will be able to update to version 12.00.024
I hope that it will solve our problem, I will keep you updated.

Etienne


2013/9/6 Christopher Vogl <christopher.vogl@hale.at>

> Hi Etienne,
>
>
> On 05/09/13 09:54, Etienne Mabille wrote:
>
>> Hi everyone,
>>
>> I am using the Telit HE910 modem with the "telit: rework for HE910"
>> patches shared by Jonas Bonn on the 4th of april 2013.
>>
>> After some endurence testing I realize that sometimes (around 25% of the
>> time) the initialisation process freezes after switching sim state satus=
 to
>> 2.
>> I assume that the driver then waits for a signal from the modem, but this
>> signal never comes.
>> When this happens, the only way I found is to hard-reset the modem...
>> Is there a way to stimulate the modem in order to continue the
>> initialisation sequence ?
>>
>> Thanks in advance,
>>
>> Etienne
>>
>
> What's the firmware version of your modem? I noticed that behaviour with
> firmware versions below 12.00.003.
>
> Regards,
> Christopher
>
> --
> Scanned by MailScanner.
>
>

--===============6324745338543374386==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgQ2hyaXN0b3BoZXIsPGRpdj48YnI+PC9kaXY+PGRpdj5JIGRvbiYj
Mzk7dCBrbm93IGV4YWN0bHkgd2hhdCBmaXJtd2FyZSB2ZXJzaW9uIHdlIGFyZSB1c2luZyB0b2Rh
eS4gSSBrbm93IGhvd2V2ZXIgdGhhdCB3ZSB3aWxsIGJlIGFibGUgdG8gdXBkYXRlIHRvIHZlcnNp
b26gPHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEz
cHgiPjEyLjAwLjAyNDwvc3Bhbj48L2Rpdj4KPGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6
YXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTNweCI+SSBob3BlIHRoYXQgaXQgd2lsbCBzb2x2
ZSBvdXIgcHJvYmxlbSwgSSB3aWxsIGtlZXAgeW91IHVwZGF0ZWQuPC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEzcHgi
Pjxicj48L3NwYW4+PC9kaXY+PGRpdj4KPHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNh
bnMtc2VyaWY7Zm9udC1zaXplOjEzcHgiPkV0aWVubmU8L3NwYW4+PC9kaXY+PC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZXh0cmEiPjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTMv
OS82IENocmlzdG9waGVyIFZvZ2wgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86
Y2hyaXN0b3BoZXIudm9nbEBoYWxlLmF0IiB0YXJnZXQ9Il9ibGFuayI+Y2hyaXN0b3BoZXIudm9n
bEBoYWxlLmF0PC9hPiZndDs8L3NwYW4+PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij5IaSBFdGllbm5lLDxkaXY+PGRpdiBjbGFzcz0iaDUiPjxicj4KPGJy
PgpPbiAwNS8wOS8xMyAwOTo1NCwgRXRpZW5uZSBNYWJpbGxlIHdyb3RlOjxicj4KPGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxl
ZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CkhpIGV2ZXJ5b25lLDxicj4KPGJy
PgpJIGFtIHVzaW5nIHRoZSBUZWxpdCBIRTkxMCBtb2RlbSB3aXRoIHRoZSAmcXVvdDt0ZWxpdDog
cmV3b3JrIGZvciBIRTkxMCZxdW90OyBwYXRjaGVzIHNoYXJlZCBieSBKb25hcyBCb25uIG9uIHRo
ZSA0dGggb2YgYXByaWwgMjAxMy48YnI+Cjxicj4KQWZ0ZXIgc29tZSBlbmR1cmVuY2UgdGVzdGlu
ZyBJIHJlYWxpemUgdGhhdCBzb21ldGltZXMgKGFyb3VuZCAyNSUgb2YgdGhlIHRpbWUpIHRoZSBp
bml0aWFsaXNhdGlvbiBwcm9jZXNzIGZyZWV6ZXMgYWZ0ZXIgc3dpdGNoaW5nIHNpbSBzdGF0ZSBz
YXR1cyB0byAyLjxicj4KSSBhc3N1bWUgdGhhdCB0aGUgZHJpdmVyIHRoZW4gd2FpdHMgZm9yIGEg
c2lnbmFsIGZyb20gdGhlIG1vZGVtLCBidXQgdGhpcyBzaWduYWwgbmV2ZXIgY29tZXMuPGJyPgpX
aGVuIHRoaXMgaGFwcGVucywgdGhlIG9ubHkgd2F5IEkgZm91bmQgaXMgdG8gaGFyZC1yZXNldCB0
aGUgbW9kZW0uLi48YnI+CklzIHRoZXJlIGEgd2F5IHRvIHN0aW11bGF0ZSB0aGUgbW9kZW0gaW4g
b3JkZXIgdG8gY29udGludWUgdGhlIGluaXRpYWxpc2F0aW9uIHNlcXVlbmNlID88YnI+Cjxicj4K
VGhhbmtzIGluIGFkdmFuY2UsPGJyPgo8YnI+CkV0aWVubmU8YnI+CjwvYmxvY2txdW90ZT4KPGJy
PjwvZGl2PjwvZGl2PgpXaGF0JiMzOTtzIHRoZSBmaXJtd2FyZSB2ZXJzaW9uIG9mIHlvdXIgbW9k
ZW0/IEkgbm90aWNlZCB0aGF0IGJlaGF2aW91ciB3aXRoIGZpcm13YXJlIHZlcnNpb25zIGJlbG93
IDEyLjAwLjAwMy48YnI+Cjxicj4KUmVnYXJkcyw8YnI+CkNocmlzdG9waGVyPGJyPgo8YnI+Ci0t
PGJyPgpTY2FubmVkIGJ5IE1haWxTY2FubmVyLjxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+
PGJyPjwvZGl2Pgo=

--===============6324745338543374386==--

