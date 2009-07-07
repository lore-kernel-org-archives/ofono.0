Content-Type: multipart/mixed; boundary="===============3498590997587817494=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Parse SIM alpha fields (EF-SPN) according to TS 11.11.
Date: Mon, 06 Jul 2009 19:42:39 -0500
Message-ID: <200907061942.39687.denkenz@gmail.com>
In-Reply-To: <1246763641-17247-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3498590997587817494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Your patch was a 'bit' inefficient, generating way too many function calls.=
  =

I've pushed my own version called sim_string_to_utf8, which can be found in =

util.c. =


Please review it for any issues..

Regards,
-Denis

--===============3498590997587817494==--

