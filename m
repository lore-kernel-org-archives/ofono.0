Content-Type: multipart/mixed; boundary="===============7753910927827276144=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp: Handle +CCWA at HFP connection setup
Date: Mon, 04 Apr 2016 14:43:34 -0500
Message-ID: <5702C3E6.20105@gmail.com>
In-Reply-To: <1459758985-21457-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7753910927827276144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 04/04/2016 03:36 AM, Kuba Pawlak wrote:
> Some phones with an active and waiting call at the time of HFP SLC
> establishment, may send call waiting notification before all calls
> are synchronized. This will lead to call Id mismatch because call
> object is created with assumed Id 1 and not Id assigned by the phone.
>
> In example below waiting call is created with Id 1 but in AT+CLCC
> this phone returns active call as call with Id 1, and waiting as 2.

Applied, thanks.

Regards,
-Denis


--===============7753910927827276144==--

