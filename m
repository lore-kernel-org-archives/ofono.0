Content-Type: multipart/mixed; boundary="===============0999325666462261260=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: split ril_pin_change_state_cb based on functionality
Date: Sat, 06 Aug 2016 11:05:52 -0500
Message-ID: <57A60AE0.2000002@gmail.com>
In-Reply-To: <1470457650-11044-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0999325666462261260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Samrat,

On 08/05/2016 11:27 PM, Samrat Guha Niyogi wrote:
> split ril_pin_change_state_cb based on functionality w.r.t.
> facility lock, puk and pin. Rename ril_pin_change_state to
> more appropriate name ril_set_facility_lock and rename
> ril_pin_change_state_cb to ril_enter_sim_pin_cb.
> ---
>   drivers/rilmodem/sim.c | 120 ++++++++++++++++++++++++++++++++++--------=
-------
>   1 file changed, 84 insertions(+), 36 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============0999325666462261260==--

