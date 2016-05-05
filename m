Content-Type: multipart/mixed; boundary="===============2990915473723629760=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: AT channel problem
Date: Thu, 05 May 2016 17:52:28 +0200
Message-ID: <CAH4ZQwt09RoO3eA_BmSdrUCRRCtmRPL1qD6FqdGmA4jXW8TrSQ@mail.gmail.com>
In-Reply-To: <572B6278.7050806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2990915473723629760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=E2=80=8BHi Denis,
=E2=80=8B


> This particular logic enables strings (e.g. text enclosed in quotes) to
> contain various special characters that would otherwise be interpreted
> differently.
>

=E2=80=8BOk, understood. I'll try to find another solution.=E2=80=8B

It looks like you have an unterminated " in one of the AT command
> responses...


=E2=80=8BI will check for this, but what I think is that the state variable=
 is set
outside the syntax state machine, because in my added prints I see that it
is already set to GSM_PERMISSIVE_STATE_RESPONSE_STRING before any parsing.

Does it look strange to you?=E2=80=8B

=E2=80=8BThank you,
Enrico=E2=80=8B

--===============2990915473723629760==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWls
eTp2ZXJkYW5hLHNhbnMtc2VyaWY7ZGlzcGxheTppbmxpbmUiPuKAi0hpIERlbmlzLDwvZGl2Pjwv
ZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZl
cmRhbmEsc2Fucy1zZXJpZjtkaXNwbGF5OmlubGluZSI+4oCLPC9kaXY+wqA8L2Rpdj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7
Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO2JvcmRlci1sZWZ0
LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PHNwYW4gY2xhc3M9IiI+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtib3Jk
ZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjwvYmxvY2tx
dW90ZT48L3NwYW4+VGhpcyBwYXJ0aWN1bGFyIGxvZ2ljIGVuYWJsZXMgc3RyaW5ncyAoZS5nLiB0
ZXh0IGVuY2xvc2VkIGluIHF1b3RlcykgdG8gY29udGFpbiB2YXJpb3VzIHNwZWNpYWwgY2hhcmFj
dGVycyB0aGF0IHdvdWxkIG90aGVyd2lzZSBiZSBpbnRlcnByZXRlZCBkaWZmZXJlbnRseS48YnI+
PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+4oCLT2ssIHVuZGVyc3Rv
b2QuIEkmIzM5O2xsIHRyeSB0byBmaW5kIGFub3RoZXIgc29sdXRpb24u4oCLPC9kaXY+PC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fu
cy1zZXJpZiI+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxl
ZnQtc3R5bGU6c29saWQ7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5n
LWxlZnQ6MWV4Ij4KSXQgbG9va3MgbGlrZSB5b3UgaGF2ZSBhbiB1bnRlcm1pbmF0ZWQgJnF1b3Q7
IGluIG9uZSBvZiB0aGUgQVQgY29tbWFuZCByZXNwb25zZXMuLi48L2Jsb2NrcXVvdGU+PGRpdj48
YnI+PC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1p
bHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7igItJIHdpbGwgY2hlY2sgZm9yIHRoaXMsIGJ1dCB3aGF0
IEkgdGhpbmsgaXMgdGhhdCB0aGUgc3RhdGUgdmFyaWFibGUgaXMgc2V0IG91dHNpZGUgdGhlIHN5
bnRheCBzdGF0ZSBtYWNoaW5lLCBiZWNhdXNlIGluIG15IGFkZGVkIHByaW50cyBJIHNlZSB0aGF0
IGl0IGlzIGFscmVhZHkgc2V0IHRvIEdTTV9QRVJNSVNTSVZFX1NUQVRFX1JFU1BPTlNFX1NUUklO
RyBiZWZvcmUgYW55IHBhcnNpbmcuPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPkRv
ZXMgaXQgbG9vayBzdHJhbmdlIHRvIHlvdT/igIs8L2Rpdj48YnI+PC9kaXY+PGRpdj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlm
Ij7igItUaGFuayB5b3UsPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZv
bnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+RW5yaWNv4oCLPC9kaXY+PGJyPjwvZGl2Pjwv
ZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============2990915473723629760==--

