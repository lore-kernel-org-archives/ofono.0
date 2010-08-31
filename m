Content-Type: multipart/mixed; boundary="===============7794216032848916179=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: Clarification on USSD support in ofono
Date: Tue, 31 Aug 2010 16:59:58 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A0E1A1@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1283257765.7452.7.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7794216032848916179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Marcel,

>   Currently, oFono expects the USSD string in UTF-8. ofono(Atom driver
> - AT or ISI) converts the UTF-8 string to GSM 7-bit default alphabet =

> and sends it to the network. In this way, we will always send the data

> coding scheme as GSM 7-bit default alphabet or whatever the character =

> set modem is configured. Why are we not sending the USSD string with =

> DCS(Data coding scheme) as is to the network? There are USIM =

> conformance test cases which expects the DCS(Data coding scheme) and =

> USSD string sent as it is to the network. Also, as per the 3GPP TS =

> 24.090, DCS and USSD string are sent as part of UnstructuredSS-Request

> to the network and MT is not expected to interpret the string.
> But ,here oFono doesn't have the interface to accept DCS(Data coding
> scheme) and also it expects the USSD string to be in UTF-8. =


> the one main design goal behind oFono's D-Bus APIs is to make them
useful for users. This means that the main input data type are strings
and they are UTF-8.

> If you need magic binary APIs that are only used by specific
application or even purely for conformance testing, then you need to
propose an interface for these. By default we will not make application
> to any kind of conversation.

> Every single nasty conversion that has to be done by every single
application using such an interface is wrong. Complexity belongs into
oFono and not the application. The idea of just pushing complex =

> tasks up into the application so that oFono doesn't have to deal with
it is a really bad idea. Remember that one main goal of oFono is to make
the usage of standard telephony functionality as easy as
> possible when you are developing telephony applications.


I'm not proposing any changes to the dbus interface and I completely
understand that its a very bad idea to push the conversions to the
application side. USAT conformance specification expects that the
information sent by the application toolkit to be sent as it is to the
network. Conformance test setup is such that if the data received at the
network doesn't match with the data sent by the application toolkit then
the conformance test case is considered to be a failure case.

When a Send USSD proactive command is received, STK atom sends an
internal request to the USSD atom to send the string along with the DCS
supplied. So, for sending the USSD string and dcs received from the
proactive command, support needs to be added to the USSD driver
interface. =

 =

What I meant was to provide a driver API which will take both the dcs
and string as parameter. something like the following:

enum ofono_dcs{
	OFONO_DCS_UNKNOWN, =

	OFONO_DCS_GSM_7BIT,
	OFONO_DCS_8BIT,
	OFONO_DCS_UCS2,
};

void (*request)(struct ofono_ussd *ussd, int dcs, const char *str,
			ofono_ussd_cb_t, void *data);

If the dcs is set to OFONO_DCS_UNKNOWN, then the conversion from UTF-8
to GSM 7 bit default alphabet needs to be done. Anything other than
OFONO_DCS_UNKNOWN, modem driver doesn't need to do any conversion and
sends the dcs and string as it is to the network. =


Regards,
jeevaka

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============7794216032848916179==--

