Content-Type: multipart/mixed; boundary="===============4612989210958588935=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] telit: add additional port for data connection
Date: Mon, 20 Aug 2012 08:11:38 -0500
Message-ID: <5032378A.50403@gmail.com>
In-Reply-To: <1345194276-30324-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4612989210958588935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/17/2012 04:04 AM, Christopher Vogl wrote:
> Use MDM port for data service and AUX for the AT chat.
> Disable DCD so that the modem does not hangup after a data connection.
> ---
>   plugins/telit.c |   55 ++++++++++++++++++++++++++++++++++--------------=
-------
>   1 files changed, 34 insertions(+), 21 deletions(-)
>

Both patches have been applied, however I had to fix:

     plugins/telit.c: In function =E2=80=98rsen_disable_cb=E2=80=99:
     plugins/telit.c:446:21: error: unused variable =E2=80=98data=E2=80=99

Regards,
-Denis


--===============4612989210958588935==--

