Content-Type: multipart/mixed; boundary="===============8668334435903578105=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: MNC/MCC as string?
Date: Wed, 10 Jun 2009 14:26:07 +0300
Message-ID: <5338cd9d9e632d7614da20e4277889b6@localhost>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8668334435903578105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

Currently, the MNC and MCC values are of type short, which is a little
problematic. =


The MNC code can either be 2 or 3 digits, and it would be quite natural to
assume the logic is that 3 digits are used for codes > 99. However, this is
not correct -- it depends on the MCC. It seems mostly American operators
have 3 digit MNCs, whereas most of the rest of the world 2 digit MNCs. The
implication is that 01 and 001 are not considered identical.

Nokia modems both send and receive MNC/MCC pairs as Binary Coded Decimal
(BCD) strings. Any 2 digit MNC is padded with 0xF. Problem is, when listing
operators, the conversion of MNC codes from BCD to short loses this
information, and will result in manual network selection failing (BCD '001'
-> short '1' -> BCD '01F' !=3D BCD '001').

Anyone opposed to changing the mnc and mcc code types from short to string?


Cheers,
Aki

--===============8668334435903578105==--

