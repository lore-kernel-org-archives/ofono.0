Content-Type: multipart/mixed; boundary="===============4010545196303736475=="
MIME-Version: 1.0
From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [RFC] AGPS Support
Date: Fri, 22 Oct 2010 12:09:22 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C105791945944934@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <B4268AAFAFA3E244B5B0641D5914917048B5476159@EXDCVYMBSTM006.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4010545196303736475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bastian,

> Bastian, Waldo wrote:
> =

> Please find attached a proposal for both a DBUS and Modem API for AGPS =

> support. There are some minor changes compared to the proposal from =

> May 14, 2010.
> =

...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void SendLCSFrame(=
string frametype, string framedata)
> =

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Send a LCS position protocol frame to the Mobile
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Network. The LCS frame typically represents a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Position Response.
> =

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Valid frametypes are:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rrlp_measure_position_response
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rrc_measurement_report
> =

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0The raw frame data is formatted as the concatenated
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sequence of the two digit hexadecimal representation
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0of each of its octets. Example: "00FC2345"
....
> struct ofono_lcs_frame {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum ofono_lcs_frame_type lcs_frame_type;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int frame_length; =C2=A0 =C2=A0 =C2=A0 /* size=
 of raw_frame in bytes */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char* raw_frame;
> };



The 27.007 Spec specifies positioning request/responses for AT where
Positioning data are coded in XML data structures.

I think the oFono interface should not use binary data, but rather be align=
ed with 27.007
and present decoded data as DBUS typed signals and methods with the same in=
formation =

content as specified in the XML data for AT+CPOS, AT+CPOSR.

In this way the vanilla AT driver could handle the CPOS, CPOR AT-commands
and code/decode between XML and explicit data structures, which in turn
oFono Core could code/decode as DBUS data types.

Regards,
Sjur Br=C3=A6ndeland

--===============4010545196303736475==--

