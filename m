Content-Type: multipart/mixed; boundary="===============6228657129269500664=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [RFC PATCH v1 2/2] huawei: fix online logic
Date: Fri, 17 Sep 2010 17:16:53 +0300
Message-ID: <87ocbwcv56.fsf@potku.valot.fi>
In-Reply-To: <87sk18cvzr.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6228657129269500664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kalle.valo@canonical.com> writes:

> I'm guessing ofono_sim_inserted_notify() has something to do this. When
> I did some quick tests, IIRC I was able to see HUAWEI_SIM_STATE_VALID
> only after I had called ofono_sim_inserted_notify(). =

>
> I think the way you are after is that we would first receive
> HUAWEI_SIM_STATE_VALID (or the three other valid states) and only then
> call ofono_sim_inserted_notify(). At least to me that would make sense.
> I just don't know how to do that because I see only later in the
> initialisation phase.

Just to show my problem. I did this on top of my two huawei v1 patches:

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 0b4e65e..ac26a02 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -185,9 +185,9 @@ static gboolean notify_sim_state(struct ofono_modem *mo=
dem,
        case HUAWEI_SIM_STATE_INVALID_OR_LOCKED:
                ofono_modem_set_powered(modem, TRUE);
 =

-               if (data->sim)
-                       ofono_sim_inserted_notify(data->sim, TRUE);
-               break;
+               /* if (data->sim) */
+               /*      ofono_sim_inserted_notify(data->sim, TRUE); */
+               return TRUE;
        case HUAWEI_SIM_STATE_VALID:
        case HUAWEI_SIM_STATE_INVALID_CS:
        case HUAWEI_SIM_STATE_INVALID_PS:
@@ -199,8 +199,8 @@ static gboolean notify_sim_state(struct ofono_modem *mo=
dem,
                 */
                ofono_modem_set_powered(modem, TRUE);
 =

-               if (data->sim)
-                       ofono_sim_inserted_notify(data->sim, TRUE);
+               /* if (data->sim) */
+               /*      ofono_sim_inserted_notify(data->sim, TRUE); */
 =

                if (data->online_cbd) {
                        cb =3D data->online_cbd->cb;

So we are not calling sim_inserted() at all and poll for sim states for
a while. And the output in cold start case is this:

Sep 17 17:14:29 dell-m520 ofonod[2436]: plugins/huawei.c:notify_sim_state()=
 255
Sep 17 17:14:32 dell-m520 ofonod[2436]: plugins/huawei.c:notify_sim_state()=
 0
Sep 17 17:14:32 dell-m520 ofonod[2436]: plugins/huawei.c:notify_sim_state()=
 0
Sep 17 17:14:34 dell-m520 ofonod[2436]: plugins/huawei.c:notify_sim_state()=
 0
Sep 17 17:14:34 dell-m520 ofonod[2436]: plugins/huawei.c:notify_sim_state()=
 0
Sep 17 17:14:36 dell-m520 ofonod[2436]: plugins/huawei.c:notify_sim_state()=
 0
Sep 17 17:14:36 dell-m520 ofonod[2436]: plugins/huawei.c:notify_sim_state()=
 0
Sep 17 17:14:38 dell-m520 ofonod[2436]: plugins/huawei.c:notify_sim_state()=
 0

My modem always stays in HUAWEI_SIM_STATE_INVALID_OR_LOCKED (0) case
forever.

-- =

Kalle Valo

--===============6228657129269500664==--

