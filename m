Content-Type: multipart/mixed; boundary="===============4105645192873160295=="
MIME-Version: 1.0
From: Aravindan, RajagopalX <rajagopalx.aravindan@intel.com>
Subject: RE: [PATCH 1/3] ril_sofia3gr: Modem throttling changes
Date: Thu, 26 May 2016 06:30:35 +0000
Message-ID: <558A060E088946499A190EEB775EEEC4F72B50@BGSMSX103.gar.corp.intel.com>
In-Reply-To: <57447BA5.4090406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4105645192873160295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

Appreciate adding my name to the list of authors :) !

Thanks & Regards,
Rajagopal
________________________________________
From: ofono [ofono-bounces(a)ofono.org] on behalf of Denis Kenzior [denkenz=
(a)gmail.com]
Sent: Tuesday, May 24, 2016 9:34 PM
To: ofono(a)ofono.org
Cc: Muralidharan, Nagarajan; Guha Niyogi, Samrat
Subject: Re: [PATCH 1/3] ril_sofia3gr: Modem throttling changes

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

_______________________________________________
ofono mailing list
ofono(a)ofono.org
https://lists.ofono.org/mailman/listinfo/ofono

--===============4105645192873160295==--

