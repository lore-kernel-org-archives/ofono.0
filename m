Content-Type: multipart/mixed; boundary="===============8989418337044023432=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2] atmodem: Poll SIM state after having entered PIN
Date: Tue, 17 Apr 2012 03:10:33 -0500
Message-ID: <4F8D2579.6090901@gmail.com>
In-Reply-To: <4F8D42CA.4050102@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8989418337044023432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>> Who owns the cbd data in this case? Are we not leaking that here?
>>
> =

> Yes, we are. I see 2 options here:
> a- Tweaking current at_util_sim_state_query_new(GAtChat *chat,
>                         guint interval, guint num_times,
>                         at_util_sim_inserted_cb_t cb,
>                         void *userdata, GDestroyNotify data_destroy); in
> adding a destroyer for user data
> =

> b- Implementing new gpointer at_util_sim_state_query_get_data(struct
> at_util_sim_state_query *req); and free user_data during remove
> =


Option a would be fine.

Regards,
-Denis

--===============8989418337044023432==--

