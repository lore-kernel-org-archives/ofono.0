Content-Type: multipart/mixed; boundary="===============3310380915319162762=="
MIME-Version: 1.0
From: Freedreamer <freedreamer@email.it>
Subject: SAGEM HiloNC v2 Driver
Date: Tue, 26 Mar 2013 10:07:16 +0100
Message-ID: <CAAs3wMghwuHCe3WFDGUV4HnE6PjStC2a_EzU1L91TWzN41epvA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3310380915319162762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everybody,

I'm developing a driver for an embedded system which uses a sagem HiloNC v2
and I really should need your help. It's my will to commit everything when
shall be ready and working.
First of all I will tell you what i did..I created a plugin sagem.c ,added
a new Vendor ,  modified makefile & other stuff and seems to work properly.
I started from calypso driver 'cause the modem is based on a Uart and I
needed the MUX over that.
With a very raw/dirty code I was able to use PPP/SMS/net service over
virtual com.. Very good work dude! :)

Now I would like to clean up my code and get a better understanding of the
stack. Unfortunately I saw that functions/modules are not always commented
so I have to ask u a lot of questions (maybe also trivial):

1) AT cmds sent with "g_at_chat_send" are always async , is that right ? Is
there any chance to get them sync ?
2) in enable fnc the modem is powered but The sim is not ready so sometimes
It hangs up...Do I have to to poll the sim status until is ready  , or the
driver will do  that by itself ?
3) could u explain me what should I really do in virtual fnc  set_online /
post_online ? i tried to stub them but they have not never been called...
4) unfortunately this modem has a SIM detection URC but it reset itself
every time the status changes... so i should call the disable function and
the enable again in order to have the MUX working... how can i do that?
5) I created and started the MUX as the first thing in enable fnc but is
that right ? sometimes seems that the modem hangs up if just powered up.
Put a delay but don't like it very much as a solution...moreover when I
power up the modem all the URC have been lost 'cause the MUX has not been
created yet..

Any help will be appreciated :)

thanks in advance

Marco

--===============3310380915319162762==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRXZlcnlib2R5LDxicj48YnI+SSYjMzk7bSBkZXZlbG9waW5nIGEgZHJpdmVyIGZvciBhbiBl
bWJlZGRlZCBzeXN0ZW0gd2hpY2ggdXNlcyBhIHNhZ2VtIEhpbG9OQyB2MiBhbmQgSSByZWFsbHkg
c2hvdWxkIG5lZWQgeW91ciBoZWxwLiBJdCYjMzk7cyBteSB3aWxsIHRvIGNvbW1pdCBldmVyeXRo
aW5nIHdoZW4gc2hhbGwgYmUgcmVhZHkgYW5kIHdvcmtpbmcuPGJyPkZpcnN0IG9mIGFsbCBJIHdp
bGwgdGVsbCB5b3Ugd2hhdCBpIGRpZC4uSSBjcmVhdGVkIGEgcGx1Z2luIHNhZ2VtLmMgLGFkZGVk
IGEgbmV3IFZlbmRvciAsoCBtb2RpZmllZCBtYWtlZmlsZSAmYW1wOyBvdGhlciBzdHVmZiBhbmQg
c2VlbXMgdG8gd29yayBwcm9wZXJseS4gSSBzdGFydGVkIGZyb20gY2FseXBzbyBkcml2ZXIgJiMz
OTtjYXVzZSB0aGUgbW9kZW0gaXMgYmFzZWQgb24gYSBVYXJ0IGFuZCBJIG5lZWRlZCB0aGUgTVVY
IG92ZXIgdGhhdC4gPGJyPgpXaXRoIGEgdmVyeSByYXcvZGlydHkgY29kZSBJIHdhcyBhYmxlIHRv
IHVzZSBQUFAvU01TL25ldCBzZXJ2aWNlIG92ZXIgdmlydHVhbCBjb20uLiBWZXJ5IGdvb2Qgd29y
ayBkdWRlISA6KTxicj48YnI+Tm93IEkgd291bGQgbGlrZSB0byBjbGVhbiB1cCBteSBjb2RlIGFu
ZCBnZXQgYSBiZXR0ZXIgdW5kZXJzdGFuZGluZyBvZiB0aGUgc3RhY2suIFVuZm9ydHVuYXRlbHkg
IEkgc2F3IHRoYXQgZnVuY3Rpb25zL21vZHVsZXMgYXJlIG5vdCBhbHdheXMgY29tbWVudGVkIHNv
IEkgaGF2ZSB0byBhc2sgdSBhIGxvdCBvZiBxdWVzdGlvbnMgKG1heWJlIGFsc28gdHJpdmlhbCk6
PGJyPgo8YnI+MSkgQVQgY21kcyBzZW50IHdpdGggJnF1b3Q7Z19hdF9jaGF0X3NlbmQmcXVvdDsg
YXJlIGFsd2F5cyBhc3luYyAsIGlzIHRoYXQgcmlnaHQgPyBJcyB0aGVyZSBhbnkgY2hhbmNlIHRv
IGdldCB0aGVtIHN5bmMgPzxicj4yKSAgaW4gZW5hYmxlIGZuYyB0aGUgbW9kZW0gaXMgcG93ZXJl
ZCBidXQgVGhlIHNpbSBpcyBub3QgcmVhZHkgc28gc29tZXRpbWVzIEl0IGhhbmdzIHVwLi4uRG8g
SSBoYXZlIHRvIHRvIHBvbGwgdGhlIHNpbSBzdGF0dXMgdW50aWwgaXMgcmVhZHmgICwgb3IgdGhl
IGRyaXZlciB3aWxsIGRvoCB0aGF0IGJ5IGl0c2VsZiA/PGJyPgozKSBjb3VsZCB1IGV4cGxhaW4g
bWUgd2hhdCBzaG91bGQgSSByZWFsbHkgZG8gaW4gdmlydHVhbCBmbmOgIHNldF9vbmxpbmUgLyBw
b3N0X29ubGluZSA/IGkgdHJpZWQgdG8gc3R1YiB0aGVtIGJ1dCB0aGV5IGhhdmUgbm90IG5ldmVy
IGJlZW4gY2FsbGVkLi4uPGJyPjQpIHVuZm9ydHVuYXRlbHkgdGhpcyBtb2RlbSBoYXMgYSBTSU0g
ZGV0ZWN0aW9uIFVSQyBidXQgaXQgcmVzZXQgaXRzZWxmIGV2ZXJ5IHRpbWUgdGhlIHN0YXR1cyBj
aGFuZ2VzLi4uIHNvIGkgc2hvdWxkIGNhbGwgdGhlIGRpc2FibGUgZnVuY3Rpb24gYW5kIHRoZSBl
bmFibGUgYWdhaW4gaW4gb3JkZXIgdG8gaGF2ZSB0aGUgTVVYIHdvcmtpbmcuLi4gaG93IGNhbiBp
IGRvIHRoYXQ/PGJyPgo1KSBJIGNyZWF0ZWQgYW5kIHN0YXJ0ZWQgdGhlIE1VWCBhcyB0aGUgZmly
c3QgdGhpbmcgaW4gZW5hYmxlIGZuYyBidXQgaXMgdGhhdCByaWdodCA/IHNvbWV0aW1lcyBzZWVt
cyB0aGF0IHRoZSBtb2RlbSBoYW5ncyB1cCBpZiBqdXN0IHBvd2VyZWQgdXAuIFB1dCBhIGRlbGF5
IGJ1dCBkb24mIzM5O3QgbGlrZSBpdCB2ZXJ5IG11Y2ggYXMgYSBzb2x1dGlvbi4uLm1vcmVvdmVy
IHdoZW4gSSBwb3dlciB1cCB0aGUgbW9kZW0gYWxsIHRoZSBVUkMgaGF2ZSBiZWVuIGxvc3QgJiMz
OTtjYXVzZSB0aGUgTVVYIGhhcyBub3QgYmVlbiBjcmVhdGVkIHlldC4uIDxicj4KPGJyPkFueSBo
ZWxwIHdpbGwgYmUgYXBwcmVjaWF0ZWQgOikgPGJyPjxicj50aGFua3MgaW4gYWR2YW5jZTxicj48
YnI+TWFyY28gPGJyPjxicj4K

--===============3310380915319162762==--

