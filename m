Content-Type: multipart/mixed; boundary="===============1867455643696723026=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: Re: [PATCH 7/7] hfp_ag_bluez5: Remove emulator when disconnect
Date: Mon, 15 Apr 2013 15:58:06 -0300
Message-ID: <CAG7KCRFSfUePBBf-AD_Rxt5hDof7qfSF==n__ij4NPd1RdFdfw@mail.gmail.com>
In-Reply-To: <516BF2F7.50508@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1867455643696723026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Apr 15, 2013 at 9:30 AM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Paulo,
>
>
> On 04/12/2013 03:41 PM, Paulo Borges wrote:
>
>> When a RequestDisconnect() is received, the emulator must be both
>> disconnected and removed from the hash.
>>
>> But an emulator can also be disconnected and freed automatically if its
>> GAtServer closes. In this case, the hash can hold an invalid pointer.
>>
>> So, after the emulator is registered, a function is set to be called
>> when the emulator is about to be freed and this function removes the
>> emulator from the hash.
>> ---
>>   plugins/hfp_ag_bluez5.c |   43 ++++++++++++++++++++++++++++++**
>> +++++++++----
>>   1 file changed, 39 insertions(+), 4 deletions(-)
>>
>
> Have you considered keeping track of the file descriptors instead?  e.g.
> simply adding a hash table of fds obtained from NewConnection() and
> g_io_add_watch()-ing on the 'HUP' condition?
>
> Regards,
> -Denis
>

I'll test this approach.

Paulo.

--===============1867455643696723026==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gTW9uLCBBcHIgMTUs
IDIwMTMgYXQgOTozMCBBTSwgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhy
ZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21h
aWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KSGkgUGF1bG8sPGRpdiBjbGFzcz0iaW0iPjxicj4KPGJyPgpP
biAwNC8xMi8yMDEzIDAzOjQxIFBNLCBQYXVsbyBCb3JnZXMgd3JvdGU6PGJyPgo8YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVm
dDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KV2hlbiBhIFJlcXVlc3REaXNjb25u
ZWN0KCkgaXMgcmVjZWl2ZWQsIHRoZSBlbXVsYXRvciBtdXN0IGJlIGJvdGg8YnI+CmRpc2Nvbm5l
Y3RlZCBhbmQgcmVtb3ZlZCBmcm9tIHRoZSBoYXNoLjxicj4KPGJyPgpCdXQgYW4gZW11bGF0b3Ig
Y2FuIGFsc28gYmUgZGlzY29ubmVjdGVkIGFuZCBmcmVlZCBhdXRvbWF0aWNhbGx5IGlmIGl0czxi
cj4KR0F0U2VydmVyIGNsb3Nlcy4gSW4gdGhpcyBjYXNlLCB0aGUgaGFzaCBjYW4gaG9sZCBhbiBp
bnZhbGlkIHBvaW50ZXIuPGJyPgo8YnI+ClNvLCBhZnRlciB0aGUgZW11bGF0b3IgaXMgcmVnaXN0
ZXJlZCwgYSBmdW5jdGlvbiBpcyBzZXQgdG8gYmUgY2FsbGVkPGJyPgp3aGVuIHRoZSBlbXVsYXRv
ciBpcyBhYm91dCB0byBiZSBmcmVlZCBhbmQgdGhpcyBmdW5jdGlvbiByZW1vdmVzIHRoZTxicj4K
ZW11bGF0b3IgZnJvbSB0aGUgaGFzaC48YnI+Ci0tLTxicj4KoCBwbHVnaW5zL2hmcF9hZ19ibHVl
ejUuYyB8IKAgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrPHU+PC91PisrKysrKysr
Ky0tLS08YnI+CqAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L2Rpdj4KSGF2ZSB5b3UgY29uc2lkZXJlZCBrZWVw
aW5nIHRyYWNrIG9mIHRoZSBmaWxlIGRlc2NyaXB0b3JzIGluc3RlYWQ/IKBlLmcuIHNpbXBseSBh
ZGRpbmcgYSBoYXNoIHRhYmxlIG9mIGZkcyBvYnRhaW5lZCBmcm9tIE5ld0Nvbm5lY3Rpb24oKSBh
bmQgZ19pb19hZGRfd2F0Y2goKS1pbmcgb24gdGhlICYjMzk7SFVQJiMzOTsgY29uZGl0aW9uPzxi
cj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjxk
aXY+SSYjMzk7bGwgdGVzdCB0aGlzIGFwcHJvYWNoLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
UGF1bG8uPC9kaXY+Cg==

--===============1867455643696723026==--

