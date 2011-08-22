Content-Type: multipart/mixed; boundary="===============3859043427940967797=="
MIME-Version: 1.0
From: milan.satpathy@accenture.com
Subject: RE: [Clarification Request]HFP Modem:Notification of Multiparty Call
 Created Using AG
Date: Mon, 22 Aug 2011 16:29:39 +0530
Message-ID: <10D123A956DC4B4FA9D7A48B3335836215187A4492@INDXM3131.dir.svc.accenture.com>
In-Reply-To: <mailman.6634.1314002893.5060.ofono@ofono.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3859043427940967797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Just forgot to update with some additional information on test environment =
on below issue.

Ofono Version: 0.53
Bluez Version: 4.89
Environment: Ubuntu 11.04
AG model: Nokia nokia 5130c-2

Let me know if any other details are required to help me on this issue.

Regards,
Milan

-----Original Message-----
From: Satpathy, Milan
Sent: Monday, August 22, 2011 4:06 PM
To: 'frederic.dalleau(a)intel.com'
Cc: 'ofono(a)ofono.org'
Subject: Re: [Clarification Request]HFP Modem:Notification of Multiparty Ca=
ll Created Using AG

Hi Fredric,

Please find the attached dbus-monitor & hcidump log for the discussed use-c=
ase (ref: ofono Digest, Vol 28, Issue 40). Please let me know what you thin=
k of this issue.

Regards,
Milan

----------------------------------------------------------------------------

Date: Mon, 22 Aug 2011 10:31:46 +0200
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: ofono(a)ofono.org
Subject: Re: [Clarification Request]HFP Modem:Notification of
        Multiparty Call Created Using AG
Message-ID:
        <CA+QXtDtSLswPbGcWi3a1arwbuiVnwde-6xhs6w1C0RcAUFNEzg@mail.gmail.c=
om>
Content-Type: text/plain; charset=3DISO-8859-1

Hi Milan,

> Is there a specific reason to limit the availability of multiparty call
> support initiated through Ofono only?

There is no such limitation. The status of multiparty call is sent to
an handsfree in +CLCC message response. If it is not the case, it
could be a bug either in oFono or in the handsfree.  Can you
provide more details about your setup and ideally an hcidump log?
I'd also recommend you to use a newer version of oFono since
multiparty call management (+CHLD) is not complete in 0.48.

Regards,
Fr?d?ric


This message is for the designated recipient only and may contain privilege=
d, proprietary, or otherwise private information.  If you have received it =
in error, please notify the sender immediately and delete the original.  An=
y other use of the email by you is prohibited.

--===============3859043427940967797==--

