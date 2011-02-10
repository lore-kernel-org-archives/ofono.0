Content-Type: multipart/mixed; boundary="===============7751706471212399551=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH 5/7] cdmamodem: Add Signal Strength Support
Date: Wed, 09 Feb 2011 20:16:08 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702F8D7B7@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <4D535000.1000301@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7751706471212399551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Dara,

> -----Original Message-----
> From: Dara Spieker-Doyle [mailto:dara.spiekerdoyle(a)gmail.com] =

> =

> Hi Rajesh
> =

> On 02/09/2011 02:58 PM, ext Rajesh.Nagaiah(a)elektrobit.com wrote:
> =

> > Hi Dara,
> >
> >> -----Original Message-----
> >> From: ofono-bounces(a)ofono.org
> >> [mailto:ofono-bounces(a)ofono.org] On Behalf Of Dara Spieker-Doyle
> >> Sent: 08 February 2011 13:05
> >> To: ofono(a)ofono.org
> >> Subject: [PATCH 5/7] cdmamodem: Add Signal Strength Support
> >>
> >
> >> +static gboolean cdma_get_next_number(const char *line, gint
> >> *number) {
> >> +     int pos;
> >> +     int end;
> >> +     int len;
> >> +     int value =3D 0;
> >> +
> >> +     len =3D strlen(line);
> >> +
> >> +     pos =3D 0;
> >> +     end =3D pos;
> >> +
> >> +     while (line[end]>=3D '0'&&  line[end]<=3D '9') {
> >> +             value =3D value * 10 + (int)(line[end] - '0');
> >> +             end +=3D 1;
> >> +     }
> >> +
> >> +     if (pos =3D=3D end)
> >> +             return FALSE;
> >> +
> >> +     pos =3D skip_to_next_field(line, end, len);
> >> +
> >> +     if (number)
> >> +             *number =3D value;
> >> +
> >> +     return TRUE;
> >> +}
> >> +
> >
> > This is a duplicate of g_at_result_iter_next_number().
> > Why cant use this function instead of cdma_get_next_number() ?
> =

> This is different from g_at_result_iter_next_number() in that =

> it takes a raw response line to parse rather than the result =

> iterator. The AT syntax format of the response from this CDMA =

> device does not follow the GSM standard AT syntax format.
> =

> >
> >> +static void cdma_csq_cb(gboolean ok, GAtResult *result, gpointer
> >> +user_data) {
> >> +     struct cb_data *cbd =3D user_data;
> >> +     ofono_cdma_netreg_strength_cb_t cb =3D cbd->cb;
> >> +     const char *prefix =3D cbd->user;
> >> +     struct ofono_error error;
> >> +     const char *attr;
> >> +     int strength =3D -1;
> >> +
> >> +     decode_at_error(&error, g_at_result_final_response(result));
> >> +
> >> +     if (!ok) {
> >> +             cb(&error, -1, cbd->data);
> >> +             return;
> >> +     }
> >> +
> >> +     if (at_util_parse_attr(result, prefix,&attr) =3D=3D FALSE) {
> >> +             CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> >> +             return;
> >> +     }
> >> +
> >> +     cdma_get_next_number(attr,&strength);
> >> +
> >> +     DBG("csq_cb: %d", strength);
> >> +
> >> +     cb(&error, at_util_convert_signal_strength(strength),
> >> cbd->data); }
> >
> > Refer csq_cb() implementation in =

> > /drivers/atmodem/network-registration.c
> >
> =

> If you are referring to the AT result iterator use in the atmodem csq
> callback:- we cannot use that here due to the response format =

> of this CDMA device not being the same as the GSM standard.
> The prefix in this case is actually not in the same line as =

> the actual response line, so I just opted to use the same =

> algorithm as attr_cb() in /drivers/cdmamodem/devinfo for now =

> and re-use at_util_parse_attr(), taking the last line as the response.
> This could well need to be extended for alternative CDMA AT =

> devices added in the future, as the CDMA AT syntax is not =

> standardised.

Can you send whats the actual result of AT+CSQ from the modem ?
If the last line is going to be only one number value, then you
can use some utility function to convert that string to a numeric value,
rather than duplicating g_at_result_iter_next_number() logic.

BR,
Rajesh

--===============7751706471212399551==--

