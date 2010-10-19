Content-Type: multipart/mixed; boundary="===============2198584838523521840=="
MIME-Version: 1.0
From: mamata l <mamata.lingala@gmail.com>
Subject: Need clarification in querying the pin status
Date: Tue, 19 Oct 2010 19:50:30 +0530
Message-ID: <AANLkTi=H6EyU+axbHFavYR3DqYo7BVByTnLHje_3hKUq@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2198584838523521840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I need clarification for querying the pin status when enabling/disabling pin
fails and the maximum number of attempts of wrong password are reached in
the modem.

I am trying to enable pin with the wrong password, and trying to get the pin
status. I observe that the maximum number of attempts for wrong password
have reached and the modem has reached to puk state and also the modem
de-registers from network.
In this case when i tried to get the properties using "GetProperties", the
properties from the ofono core are received without querying the information

from the modem. The "PinRequired" received is "none" .

Could you please provide some info how to get the sim pin state when sim is
blocked on puk at run-time and is there any way for app to know the number
of attempts remaining.

Thanks,
Mamata

--===============2198584838523521840==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj5JIG5lZWQgY2xhcmlmaWNhdGlvbiBmb3IgcXVlcnlpbmcgdGhlIHBpbiBzdGF0
dXMgd2hlbiBlbmFibGluZy9kaXNhYmxpbmcgcGluIGZhaWxzIGFuZCB0aGUgbWF4aW11bSBudW1i
ZXIgb2YgYXR0ZW1wdHMgb2Ygd3JvbmcgcGFzc3dvcmQgYXJlIHJlYWNoZWQgaW4gdGhlIG1vZGVt
Ljxicj48YnI+SSBhbSB0cnlpbmcgdG8gZW5hYmxlIHBpbiB3aXRoIHRoZSB3cm9uZyBwYXNzd29y
ZCwgYW5kIHRyeWluZyB0byBnZXQgdGhlIHBpbiBzdGF0dXMuIEkgb2JzZXJ2ZSB0aGF0IHRoZSBt
YXhpbXVtIG51bWJlciBvZiBhdHRlbXB0cyBmb3Igd3JvbmcgcGFzc3dvcmQgPGJyPgpoYXZlIHJl
YWNoZWQgYW5kIHRoZSBtb2RlbSBoYXMgcmVhY2hlZCB0byBwdWsgc3RhdGUgYW5kIGFsc28gdGhl
IG1vZGVtIGRlLXJlZ2lzdGVycyBmcm9tIG5ldHdvcmsuIDxicj5JbiB0aGlzIGNhc2Ugd2hlbiBp
IHRyaWVkIHRvIGdldCB0aGUgcHJvcGVydGllcyB1c2luZyAmcXVvdDtHZXRQcm9wZXJ0aWVzJnF1
b3Q7LCB0aGUgcHJvcGVydGllcyBmcm9tIHRoZSBvZm9ubyBjb3JlIGFyZSByZWNlaXZlZCB3aXRo
b3V0IHF1ZXJ5aW5nIHRoZSBpbmZvcm1hdGlvbiA8YnI+CmZyb20gdGhlIG1vZGVtLiBUaGUgJnF1
b3Q7UGluUmVxdWlyZWQmcXVvdDsgcmVjZWl2ZWQgaXMgJnF1b3Q7bm9uZSZxdW90OyAuPGJyPjxi
cj5Db3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgc29tZSBpbmZvIGhvdyB0byBnZXQgdGhlIHNpbSBw
aW4gc3RhdGUgd2hlbiBzaW0gaXMgYmxvY2tlZCBvbiBwdWsgYXQgcnVuLXRpbWUgYW5kIGlzIHRo
ZXJlIGFueSB3YXkgZm9yIGFwcCB0byBrbm93IHRoZSBudW1iZXIgb2YgYXR0ZW1wdHMgcmVtYWlu
aW5nLjxicj4KPGJyPlRoYW5rcyw8YnI+TWFtYXRhPGJyPgo=

--===============2198584838523521840==--

