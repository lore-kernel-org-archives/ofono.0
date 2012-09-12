Content-Type: multipart/mixed; boundary="===============4235047177343631869=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] netreg: Add telit version for ciev notification
Date: Wed, 12 Sep 2012 08:53:02 -0500
Message-ID: <505093BE.2080203@gmail.com>
In-Reply-To: <50504445.1000908@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4235047177343631869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

>>
>> Also, I made failing to initialize +CMER fatal in commit
>> b274e74102c7a4b96c06dba895cf0cb444fa54c3. Can you please double-check
>> that it is working as intended, I only performed basic sanity checking
>> on my end.
>
> I sent the CMER-string that is not supported by Telit (3,0,0,1) and the
> netreg atom gets removed after a corresponding error message (the modem
> still sets up a ppp connection afterwards):
>

Strange, ofono shouldn't even let you attach or activate the context =

until after the netreg atom is fully initialized.  Do you have a log?

Regards,
-Denis

--===============4235047177343631869==--

