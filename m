Content-Type: multipart/mixed; boundary="===============4471220236684630033=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Re: [PATCH 4/4] TODO: Marking the Barred Dialing task as done
Date: Mon, 06 Dec 2010 19:59:00 +0530
Message-ID: <AANLkTi=miVmCvvzHTA=athkJjxSRCVNJ9c21xTLxL+v0@mail.gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802C40B22@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4471220236684630033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

Thanks for confirming.

On Mon, Dec 6, 2010 at 6:52 PM, <Jeevaka.Badrappan@elektrobit.com> wrote:

> Hi Sankar,
>
> > Is there a way for the clients to enable or disable the Fixed
> Dialling? I assume they should be able to do this by using the dbus
> calls, "LockPin/UnlockPin".  Is there a
> > way to store the FDN numbers in the sim card? How does ofono validate
> the request to be passed to the network when FDN is enabled? Looks like
> as per the current
> > implementation of FDN, only emergency calls are allowed. But as per
> the 3GPP standards, calls shall be allowed to any number (irrespective
> of emergency no) that is part of > the FDN list.
>
> Currently, there is no way to enable or disable fixed dialling or Barred
> Dialling using oFono. If my assumption is correct, there is no plans to
> add support.(Denis/Marcel can confirm this). oFono doesn't support
> storing any numbers in the SIM storage(EFadn, EFfdn or EFbdn). Agreed as
> per the specification calls shall be allowed to any number that is part
> of the FDN list. But its been agreed that oFono will enter presim state
> when FDN or BDN service is enabled in which state only emergency calls
> are allowed.
>
Then as per your email, the support provided in Ofono seems to be limited.
If there is no enable or disable is allowed,
I am not sure, how we can we have a card in which FDN enabled, which will
force the ofono to enter presim state. Unless there is no
option to disable at, forever with that sim card, the phone will be in
presim state,leading to only placing of emergency calls.

>
> > If the modem remains in PRESIM State, how does the mobile receive the
> Incoming Calls or SMS? As per my understanding FDN applies in the uplink
> and not in the downlink.
> > Please clarify if my understanding is wrong.
>
> Yes, your understanding is correct. FDN applies to the Mobile originated
> calls, SMS etc.
>
Thanks for confirming. Then in this case, are we not forcing the mobile to
go in a state, where if FDN is already enabled in the sim card( may be from
a different phone), user allowed with no option rather than making an
emergency call.

>
> Regards,
> Jeevaka
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============4471220236684630033==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgSmVldmFrYSw8YnI+PGJyPlRoYW5rcyBmb3IgY29uZmlybWluZy48YnI+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj5PbiBNb24sIERlYyA2LCAyMDEwIGF0IDY6NTIgUE0sICA8c3BhbiBk
aXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpKZWV2YWthLkJhZHJhcHBhbkBlbGVrdHJvYml0
LmNvbSI+SmVldmFrYS5CYWRyYXBwYW5AZWxla3Ryb2JpdC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3Jv
dGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJib3JkZXItbGVm
dDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhl
eDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij5IaSBTYW5rYXIsPGJyPgo8ZGl2IGNsYXNzPSJpbSI+PGJy
PgomZ3Q7IElzIHRoZXJlIGEgd2F5IGZvciB0aGUgY2xpZW50cyB0byBlbmFibGUgb3IgZGlzYWJs
ZSB0aGUgRml4ZWQ8YnI+CkRpYWxsaW5nPyBJIGFzc3VtZSB0aGV5IHNob3VsZCBiZSBhYmxlIHRv
IGRvIHRoaXMgYnkgdXNpbmcgdGhlIGRidXM8YnI+CmNhbGxzLCAmcXVvdDtMb2NrUGluL1VubG9j
a1BpbiZxdW90Oy4goElzIHRoZXJlIGE8YnI+CiZndDsgd2F5IHRvIHN0b3JlIHRoZSBGRE4gbnVt
YmVycyBpbiB0aGUgc2ltIGNhcmQ/IEhvdyBkb2VzIG9mb25vIHZhbGlkYXRlPGJyPgp0aGUgcmVx
dWVzdCB0byBiZSBwYXNzZWQgdG8gdGhlIG5ldHdvcmsgd2hlbiBGRE4gaXMgZW5hYmxlZD8gTG9v
a3MgbGlrZTxicj4KYXMgcGVyIHRoZSBjdXJyZW50PGJyPgomZ3Q7IGltcGxlbWVudGF0aW9uIG9m
IEZETiwgb25seSBlbWVyZ2VuY3kgY2FsbHMgYXJlIGFsbG93ZWQuIEJ1dCBhcyBwZXI8YnI+CnRo
ZSAzR1BQIHN0YW5kYXJkcywgY2FsbHMgc2hhbGwgYmUgYWxsb3dlZCB0byBhbnkgbnVtYmVyIChp
cnJlc3BlY3RpdmU8YnI+Cm9mIGVtZXJnZW5jeSBubykgdGhhdCBpcyBwYXJ0IG9mICZndDsgdGhl
IEZETiBsaXN0Ljxicj4KPGJyPgo8L2Rpdj5DdXJyZW50bHksIHRoZXJlIGlzIG5vIHdheSB0byBl
bmFibGUgb3IgZGlzYWJsZSBmaXhlZCBkaWFsbGluZyBvciBCYXJyZWQ8YnI+CkRpYWxsaW5nIHVz
aW5nIG9Gb25vLiBJZiBteSBhc3N1bXB0aW9uIGlzIGNvcnJlY3QsIHRoZXJlIGlzIG5vIHBsYW5z
IHRvPGJyPgphZGQgc3VwcG9ydC4oRGVuaXMvTWFyY2VsIGNhbiBjb25maXJtIHRoaXMpLiBvRm9u
byBkb2VzbiYjMzk7dCBzdXBwb3J0PGJyPgpzdG9yaW5nIGFueSBudW1iZXJzIGluIHRoZSBTSU0g
c3RvcmFnZShFRmFkbiwgRUZmZG4gb3IgRUZiZG4pLiBBZ3JlZWQgYXM8YnI+CnBlciB0aGUgc3Bl
Y2lmaWNhdGlvbiBjYWxscyBzaGFsbCBiZSBhbGxvd2VkIHRvIGFueSBudW1iZXIgdGhhdCBpcyBw
YXJ0PGJyPgpvZiB0aGUgRkROIGxpc3QuIEJ1dCBpdHMgYmVlbiBhZ3JlZWQgdGhhdCBvRm9ubyB3
aWxsIGVudGVyIHByZXNpbSBzdGF0ZTxicj4Kd2hlbiBGRE4gb3IgQkROIHNlcnZpY2UgaXMgZW5h
YmxlZCBpbiB3aGljaCBzdGF0ZSBvbmx5IGVtZXJnZW5jeSBjYWxsczxicj4KYXJlIGFsbG93ZWQu
PGJyPjwvYmxvY2txdW90ZT48ZGl2PlRoZW4gYXMgcGVyIHlvdXIgZW1haWwsIHRoZSBzdXBwb3J0
IHByb3ZpZGVkIGluIE9mb25vIHNlZW1zIHRvIGJlIGxpbWl0ZWQuIElmIHRoZXJlIGlzIG5vIGVu
YWJsZSBvciBkaXNhYmxlIGlzIGFsbG93ZWQsPGJyPkkgYW0gbm90IHN1cmUsIGhvdyB3ZSBjYW4g
d2UgaGF2ZSBhIGNhcmQgaW4gd2hpY2ggRkROIGVuYWJsZWQsIHdoaWNoIHdpbGwgZm9yY2UgdGhl
IG9mb25vIHRvIGVudGVyIHByZXNpbSBzdGF0ZS4gVW5sZXNzIHRoZXJlIGlzIG5vPGJyPgpvcHRp
b24gdG8gZGlzYWJsZSBhdCwgZm9yZXZlciB3aXRoIHRoYXQgc2ltIGNhcmQsIHRoZSBwaG9uZSB3
aWxsIGJlIGluIHByZXNpbSBzdGF0ZSxsZWFkaW5nIHRvIG9ubHkgcGxhY2luZyBvZiBlbWVyZ2Vu
Y3kgY2FsbHMuPGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBtYXJnaW46IDBwdCAw
cHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPgoKPGRpdiBjbGFzcz0iaW0iPjxicj4K
Jmd0OyBJZiB0aGUgbW9kZW0gcmVtYWlucyBpbiBQUkVTSU0gU3RhdGUsIGhvdyBkb2VzIHRoZSBt
b2JpbGUgcmVjZWl2ZSB0aGU8YnI+CkluY29taW5nIENhbGxzIG9yIFNNUz8gQXMgcGVyIG15IHVu
ZGVyc3RhbmRpbmcgRkROIGFwcGxpZXMgaW4gdGhlIHVwbGluazxicj4KYW5kIG5vdCBpbiB0aGUg
ZG93bmxpbmsuPGJyPgomZ3Q7IFBsZWFzZSBjbGFyaWZ5IGlmIG15IHVuZGVyc3RhbmRpbmcgaXMg
d3JvbmcuPGJyPgo8YnI+CjwvZGl2PlllcywgeW91ciB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3Qu
IEZETiBhcHBsaWVzIHRvIHRoZSBNb2JpbGUgb3JpZ2luYXRlZDxicj4KY2FsbHMsIFNNUyBldGMu
PGJyPjwvYmxvY2txdW90ZT48ZGl2PlRoYW5rcyBmb3IgY29uZmlybWluZy4gVGhlbiBpbiB0aGlz
IGNhc2UsIGFyZSB3ZSBub3QgZm9yY2luZyB0aGUgbW9iaWxlIHRvIGdvIGluIGEgc3RhdGUsIHdo
ZXJlIGlmIEZETiBpcyBhbHJlYWR5IGVuYWJsZWQgaW4gdGhlIHNpbSBjYXJkKCBtYXkgYmUgZnJv
bSBhIGRpZmZlcmVudCBwaG9uZSksIHVzZXIgYWxsb3dlZCB3aXRoIG5vIG9wdGlvbiByYXRoZXIg
dGhhbiBtYWtpbmcgYW4gZW1lcmdlbmN5IGNhbGwuIDxicj4KPC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAy
MDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IHBhZGRpbmctbGVmdDogMWV4OyI+
Cjxicj4KUmVnYXJkcyw8YnI+Cjxmb250IGNvbG9yPSIjODg4ODg4Ij5KZWV2YWthPGJyPgo8L2Zv
bnQ+PGRpdj48ZGl2PjwvZGl2PjxkaXYgY2xhc3M9Img1Ij5fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBo
cmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBo
cmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFu
ayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvZGl2Pjwv
ZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+Cg==

--===============4471220236684630033==--

