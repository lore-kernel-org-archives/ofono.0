Content-Type: multipart/mixed; boundary="===============8792912666814204092=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Re: Need clarification in querying the pin status
Date: Tue, 30 Nov 2010 18:59:00 +0530
Message-ID: <AANLkTi=Vdw-LKPpYTSf6dcB7WOm_H5q2chiv13hhfq6N@mail.gmail.com>
In-Reply-To: <4CBDB2E7.5090505@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8792912666814204092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Oct 19, 2010 at 8:31 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Mamata,
>
> On 10/19/2010 09:20 AM, mamata l wrote:
> > Hi,
> >
> > I need clarification for querying the pin status when enabling/disabling
> > pin fails and the maximum number of attempts of wrong password are
> > reached in the modem.
> >
> > I am trying to enable pin with the wrong password, and trying to get the
> > pin status. I observe that the maximum number of attempts for wrong
> > password
> > have reached and the modem has reached to puk state and also the modem
> > de-registers from network.
> > In this case when i tried to get the properties using "GetProperties",
> > the properties from the ofono core are received without querying the
> > information
> > from the modem. The "PinRequired" received is "none" .
> >
> > Could you please provide some info how to get the sim pin state when sim
> > is blocked on puk at run-time and is there any way for app to know the
> > number of attempts remaining.
>
> This is actually a bug in oFono, somehow we missed the fact that
> ChangePin with the wrong PIN will decrease the retry counts.  The core
> needs to be fixed to query the current PIN state and reset the state to
> pre-sim if the retry limit is reached.
>

Can you please let us know if this is already addressed or this will be
addressed in future.

>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============8792912666814204092==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVHVlLCBPY3QgMTks
IDIwMTAgYXQgODozMSBQTSwgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhy
ZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwv
c3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwg
MjA0LCAyMDQpOyBwYWRkaW5nLWxlZnQ6IDFleDsiPgpIaSBNYW1hdGEsPGJyPgo8ZGl2PjxkaXY+
PC9kaXY+PGRpdiBjbGFzcz0iaDUiPjxicj4KT24gMTAvMTkvMjAxMCAwOToyMCBBTSwgbWFtYXRh
IGwgd3JvdGU6PGJyPgomZ3Q7IEhpLDxicj4KJmd0Ozxicj4KJmd0OyBJIG5lZWQgY2xhcmlmaWNh
dGlvbiBmb3IgcXVlcnlpbmcgdGhlIHBpbiBzdGF0dXMgd2hlbiBlbmFibGluZy9kaXNhYmxpbmc8
YnI+CiZndDsgcGluIGZhaWxzIGFuZCB0aGUgbWF4aW11bSBudW1iZXIgb2YgYXR0ZW1wdHMgb2Yg
d3JvbmcgcGFzc3dvcmQgYXJlPGJyPgomZ3Q7IHJlYWNoZWQgaW4gdGhlIG1vZGVtLjxicj4KJmd0
Ozxicj4KJmd0OyBJIGFtIHRyeWluZyB0byBlbmFibGUgcGluIHdpdGggdGhlIHdyb25nIHBhc3N3
b3JkLCBhbmQgdHJ5aW5nIHRvIGdldCB0aGU8YnI+CiZndDsgcGluIHN0YXR1cy4gSSBvYnNlcnZl
IHRoYXQgdGhlIG1heGltdW0gbnVtYmVyIG9mIGF0dGVtcHRzIGZvciB3cm9uZzxicj4KJmd0OyBw
YXNzd29yZDxicj4KJmd0OyBoYXZlIHJlYWNoZWQgYW5kIHRoZSBtb2RlbSBoYXMgcmVhY2hlZCB0
byBwdWsgc3RhdGUgYW5kIGFsc28gdGhlIG1vZGVtPGJyPgomZ3Q7IGRlLXJlZ2lzdGVycyBmcm9t
IG5ldHdvcmsuPGJyPgomZ3Q7IEluIHRoaXMgY2FzZSB3aGVuIGkgdHJpZWQgdG8gZ2V0IHRoZSBw
cm9wZXJ0aWVzIHVzaW5nICZxdW90O0dldFByb3BlcnRpZXMmcXVvdDssPGJyPgomZ3Q7IHRoZSBw
cm9wZXJ0aWVzIGZyb20gdGhlIG9mb25vIGNvcmUgYXJlIHJlY2VpdmVkIHdpdGhvdXQgcXVlcnlp
bmcgdGhlPGJyPgomZ3Q7IGluZm9ybWF0aW9uPGJyPgomZ3Q7IGZyb20gdGhlIG1vZGVtLiBUaGUg
JnF1b3Q7UGluUmVxdWlyZWQmcXVvdDsgcmVjZWl2ZWQgaXMgJnF1b3Q7bm9uZSZxdW90OyAuPGJy
PgomZ3Q7PGJyPgomZ3Q7IENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBzb21lIGluZm8gaG93IHRv
IGdldCB0aGUgc2ltIHBpbiBzdGF0ZSB3aGVuIHNpbTxicj4KJmd0OyBpcyBibG9ja2VkIG9uIHB1
ayBhdCBydW4tdGltZSBhbmQgaXMgdGhlcmUgYW55IHdheSBmb3IgYXBwIHRvIGtub3cgdGhlPGJy
PgomZ3Q7IG51bWJlciBvZiBhdHRlbXB0cyByZW1haW5pbmcuPGJyPgo8YnI+CjwvZGl2PjwvZGl2
PlRoaXMgaXMgYWN0dWFsbHkgYSBidWcgaW4gb0Zvbm8sIHNvbWVob3cgd2UgbWlzc2VkIHRoZSBm
YWN0IHRoYXQ8YnI+CkNoYW5nZVBpbiB3aXRoIHRoZSB3cm9uZyBQSU4gd2lsbCBkZWNyZWFzZSB0
aGUgcmV0cnkgY291bnRzLiCgVGhlIGNvcmU8YnI+Cm5lZWRzIHRvIGJlIGZpeGVkIHRvIHF1ZXJ5
IHRoZSBjdXJyZW50IFBJTiBzdGF0ZSBhbmQgcmVzZXQgdGhlIHN0YXRlIHRvPGJyPgpwcmUtc2lt
IGlmIHRoZSByZXRyeSBsaW1pdCBpcyByZWFjaGVkLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+
Q2FuIHlvdSBwbGVhc2UgbGV0IHVzIGtub3cgaWYgdGhpcyBpcyBhbHJlYWR5IGFkZHJlc3NlZCBv
ciB0aGlzIHdpbGwgYmUgYWRkcmVzc2VkIGluIGZ1dHVyZS4gPGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IGJv
cmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxlZnQ6IDFl
eDsiPgoKPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBo
cmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBo
cmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFu
ayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvYmxvY2tx
dW90ZT48L2Rpdj48YnI+Cg==

--===============8792912666814204092==--

