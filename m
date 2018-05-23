Content-Type: multipart/mixed; boundary="===============5501170560381892380=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Adding the ofono_sim_initialized_notify function
 after ofono_sim_inserted_notify,
 as suggested by Denis Kenzior in this commit :
 54d56d763e40bc44c99a9b24aa0477bd373ea085
Date: Wed, 23 May 2018 09:44:55 -0500
Message-ID: <3f11e274-de3d-4c68-dc8c-548fa5750a40@gmail.com>
In-Reply-To: <1526994511-302-2-git-send-email-florent.beillonnet@ext.actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5501170560381892380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florent,

On 05/22/2018 08:08 AM, Florent Beillonnet wrote:
> ---
>   plugins/gemalto.c | 2 ++
>   1 file changed, 2 insertions(+)

You really shouldn't need to do this given that you have a URC inside =

gemalto_ciev_notify() that does exactly this already.

No, I think there's a tiny bug in the core introduced by the commit you =

reference above.  Try this change?

@@ -847,7 +847,7 @@ static void sim_enter_pin_cb(const struct =

ofono_error *error, void *data)

         __ofono_dbus_pending_reply(&sim->pending, reply);

-       if (sim->initialized)
+       if (sim->initialized || error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
                 goto recheck;

         if (sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||

Regards,
-Denis

--===============5501170560381892380==--

