Content-Type: multipart/mixed; boundary="===============2783384956705501921=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] ril_sofia3gr: Modem throttling changes
Date: Tue, 24 May 2016 11:04:53 -0500
Message-ID: <57447BA5.4090406@gmail.com>
In-Reply-To: <1464079459-6525-1-git-send-email-rajagopalx.aravindan@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2783384956705501921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajagopal,

On 05/24/2016 03:44 AM, Rajagopal Aravindan wrote:
> Added 'sofia3gr.ThermalManagement' interface to sofia3gr plugin and
> floated 'TransmitPowerThrottling' as an ofono property under that,
> to support modem throttling.
>
> 'sofia3gr.ThermalManagement'
>      1.Will be available ONLY if modem throttling is supported in RIL.
>        This is determined by sending a RIL request during ofono start,
>        to get current throttling state. If it succeeds, interface is
>        published otherwise not.
>
> 'TransmitPowerThrottling'
>      1.GetProperties will be allowed both when modem is ON & OFF.
>      2.GetProperties will be serviced by looking it up from state
>        information maintained inside ofono. No RIL call will be made.
>      3.SetProperty will be allowed ONLY when modem is ON.
>      4.SetProperty request will be forwarded to RIL ONLY if
>        new state !=3D current state. If RIL request succeeds, state
>        information will be updated and also, a property change signal
>        will be emitted.
> ---
>   plugins/ril_sofia3gr.c | 292 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 292 insertions(+)
>

All three applied, thanks.

Regards,
-Denis


--===============2783384956705501921==--

