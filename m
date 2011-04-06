Content-Type: multipart/mixed; boundary="===============0753481134314139801=="
MIME-Version: 1.0
From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>
Subject: Re: [RFC PATCH v3] gprs: add function to handle activated context
Date: Wed, 06 Apr 2011 12:30:04 +0300
Message-ID: <4D9C329C.2000106@nokia.com>
In-Reply-To: <4D9C2965.4080301@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0753481134314139801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Redouane,

> The purpose of the patch is to handle Network Initiated Context =

> Activation and PDN connection request as part of EPS Attach procedure =

> (LTE) in oFono core.
>
> In order to avoid issue regarding CID allocation :
> - driver should call the core using ofono_gprs_set_cid_range function =

> to specify CID range for UE initiated PDN connection
> - driver could use a new function to check if the CID is already used =

> or not : ofono_gprs_is_cid_used, usefull in case the modem is not =

> using a specific range for UE initiated PDN connection.
> - driver will use a new function to notify the gprs atom of a new PDN =

> connection with all the ip parameters from AT+CGCONTRDP (I can provide =

> an update later to handle PCSCF and IMS Signaling Flag as well) =

> commmand : ofono_gprs_context_activated
>
27.007 section 10.1.1 says

Defined values
<cid>: a numeric parameter which specifies a particular PDP context =

definition. The parameter is local to the TE-
MT interface and is used in other PDP context-related commands. The =

range of permitted values (minimum
value =3D 1) is returned by the test form of the command.
NOTE 1: The <cid>s for network-initiated PDP contexts will have values =

outside the ranges indicated for the
<cid> in the test form of the commands +CGDCONT and +CGDSCONT.

According to this, the cid of user initiated context and network =

initiated context doesn't overlap.

Also

+CGEV: ME PDN ACT <cid>[,<reason>[,<cid_other>]]
The mobile termination has activated a context. The context represents a =

PDN connection in LTE or a Primary
PDP context in GSM/UMTS. The <cid> for this context is provided to the =

TE. This event is sent either in result
of explicit context activation request (+CGACT), or in result of =

implicit context activation request associated to
attach request (+CGATT=3D1). The format of the parameters <cid>, =

<cid_other> are found in command
+CGDCONT.

We should also be able to get the cid of the default context, from CGEV =

indications.

> ofono_gprs_context_activated is similar to =

> ofono_gprs_context_deactivated.
> This function must be call by any gprs driver when :
>  - a context has been activated without explicit request as part of =

> attach procedure in LTE (PDN ACT X and X is a unused CID)
>  - a context has been activated by the Network (NW PDN ACT X, NW ACT X,Y)
>
> Behavior of the function :
>
> List all the context and try to find correct APN with empty username =

> and empty password.
> If such context is not found then create a new one with "Internet" =

> type only if we are in LTE with no Active context.
> Otherwise deactivate the connection.
>
> For the context (found or created):
>     Update the settings
>     Set to active
>
> The function will also assign the context to a context driver.

Please correct me if i miss some information.

Regards
Arun


--===============0753481134314139801==--

