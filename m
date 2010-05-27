Content-Type: multipart/mixed; boundary="===============8246543567461457897=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] Add: Online property to modem
Date: Wed, 26 May 2010 21:05:11 -0500
Message-ID: <201005262105.11721.denkenz@gmail.com>
In-Reply-To: <1274885889-11479-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8246543567461457897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> The online/offline state is changed with the new set_online() modem driver
> method.
> =

> In order to track atoms, there are modem states as follows:
> - OFONO_MODEM_STATE_POWER_OFF
> - OFONO_MODEM_STATE_PRE_SIM
> - OFONO_MODEM_STATE_OFFLINE
> - OFONO_MODEM_STATE_ONLINE
> =

> Atoms are added with driver methods pre_sim(), post_sim() and
>  post_online(). Atoms are removed by modem core when the state changes.

Patch has been applied, however I did some refactoring afterward.  Please t=
est =

that I didn't break something.

Regards,
-Denis

--===============8246543567461457897==--

