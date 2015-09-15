Content-Type: multipart/mixed; boundary="===============3810374395353345688=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Waiting "PB DONE" message before create the phonebook
Date: Tue, 15 Sep 2015 08:05:30 -0500
Message-ID: <55F8179A.5030101@gmail.com>
In-Reply-To: <55F7F0AD.4000901@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3810374395353345688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On 09/15/2015 05:19 AM, Viallard Anthony wrote:
> Hi,
>
> My module (SIMCOM5216) sends "PB DONE" when the phonebook is ready. So,
> I would like to wait for this message before instantiated the phonebook
> interface in ofono.
>
> In the phonebook AT driver, there is a quirk for ifx vendor. So, I try
> to do the same thing, not with the "+PBREADY" message, but with "PB
> DONE" and it doesn't work.
>
> I don't known where to put my quirk. Can you give me some hints ?
>

A quirk setting is usually done in two places:

1. The atom driver itself.  e.g. drivers/atmodem/phonebook.c
2. The modem driver.  Instead of passing 0 as the second argument, you =

pass in the vendor quirk. e.g.:
	ofono_phonebook_create(modem, VENDOR_QUIRK, "atmodem", ...);

Hope this helps.

Regards,
-Denis

--===============3810374395353345688==--

