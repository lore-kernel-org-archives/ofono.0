Content-Type: multipart/mixed; boundary="===============4328592734883118564=="
MIME-Version: 1.0
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: read phonebook
Date: Sat, 11 Jun 2016 18:41:23 +0200
Message-ID: <36b89c6c-4bb7-80fe-c09a-40680a8a863d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4328592734883118564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,
I have this setup:

- RPi3
- Raspbian Jessie Lite
- bluez 5.40
- ofono 1.18

in /etc/bluetooth/main.conf I set this class: 0x640408.
Using bluetoothctl I connected my phone to the SBC and I can make a call =

using the ofono tests.

I wonder how to read the contacts. I launched test-phonebook but I got =

this error:

> Method "Import" with signature "" on interface "org.ofono.Phonebook" does=
n't exist

Do I need to enable something other before?
Thanks
Marco

--===============4328592734883118564==--

