Content-Type: multipart/mixed; boundary="===============1172898433010093109=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Clarification on USSD support in ofono
Date: Tue, 31 Aug 2010 08:29:25 -0400
Message-ID: <1283257765.7452.7.camel@localhost.localdomain>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA8029A8D64@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1172898433010093109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>   Currently, oFono expects the USSD string in UTF-8. ofono(Atom driver
> - AT or ISI) converts the UTF-8 string to GSM 7-bit default alphabet
> and sends it to the network. In this way, we will always send the data
> coding scheme as GSM 7-bit default alphabet or whatever the character
> set modem is configured. Why are we not sending the USSD string with
> DCS(Data coding scheme) as is to the network? There are USIM
> conformance test cases which expects the DCS(Data coding scheme) and
> USSD string sent as it is to the network. Also, as per the 3GPP TS
> 24.090, DCS and USSD string are sent as part of UnstructuredSS-Request
> to the network and MT is not expected to interpret the string.
> But ,here oFono doesn't have the interface to accept DCS(Data coding
> scheme) and also it expects the USSD string to be in UTF-8. =


the one main design goal behind oFono's D-Bus APIs is to make them
useful for users. This means that the main input data type are strings
and they are UTF-8.

If you need magic binary APIs that are only used by specific application
or even purely for conformance testing, then you need to propose an
interface for these. By default we will not make application to any kind
of conversation.

Every single nasty conversion that has to be done by every single
application using such an interface is wrong. Complexity belongs into
oFono and not the application. The idea of just pushing complex tasks up
into the application so that oFono doesn't have to deal with it is a
really bad idea. Remember that one main goal of oFono is to make the
usage of standard telephony functionality as easy as possible when you
are developing telephony applications.

Regards

Marcel



--===============1172898433010093109==--

