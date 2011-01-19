Content-Type: multipart/mixed; boundary="===============1089666745464394561=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [offline-atoms PATCH 2/2] Make sms atom offline-safe
Date: Tue, 18 Jan 2011 22:10:24 -0600
Message-ID: <4D366430.3000805@gmail.com>
In-Reply-To: <1295016053-31994-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1089666745464394561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 01/14/2011 08:40 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Allow use of SMS atom both in online and offline (post_sim) states.
> =

> SMS atom now watches network registration atom and state.  Thmessages
> are queued but not sent if not registered to a network.  Errors
> occurring when a short message is being sent while transition from
> online to offline or when network coverage is dropped are now handled
> gracefully.
> ---
>  src/sms.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 files changed, 91 insertions(+), 6 deletions(-)
> =


Patch looked fine to me, so I went ahead and applied it.  Can we get
this one tested ASAP on various modem drivers?

Regards,
-Denis

--===============1089666745464394561==--

