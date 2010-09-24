Content-Type: multipart/mixed; boundary="===============1983780691509889659=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Please comment on callhistory API
Date: Fri, 24 Sep 2010 10:17:05 +0900
Message-ID: <1285291025.20811.102.camel@localhost.localdomain>
In-Reply-To: <4C9BB865.4070301@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1983780691509889659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Raji,

> Attached Callhistory API , please send me your feedback on it, I will =

> extend this include SmsHistory once callhistory API looks good.

please include such text in the email and not as attachment. We wanna
review it and not bother with just having to save it to disk first, then
copy it back into the response email to have to comment on it. I prefer
reading this and patches directly in my email client.

> 							Callhistory Adapter-Agent
> =

> =

> 	CallHistoryAdapter is a built in plugin for ofono. It uses CallHistoryAg=
ent api exposed by dialer or client daemon to push voice call history infor=
mation to client. CallHistoryAgent api is an service interface exposed by c=
lient over dbus. Plugin exposes CallHistoryAdapter interface that CallHisto=
ryAgent registers and unregisters with. if the CallHistoryAgent registers w=
ith Adapter then plugin pushes the history information to dialer as soon as=
 it receives from ofono, otherwise it caches the data in a disk file until =
agent registers, once agent registers plugin will read the data from the di=
sk file and pushes all the records to it.
> =

> =

> Adapter: =

> =

> it is going to register and unregister the agent. Calls the methods on th=
e agent for delivering history information whent the agent is up and runnin=
g. If the record cant be delivered that means agent method returns an error=
 then it will be written to the disk file. If the agent is down it will per=
sist history record in disk file.
> =

> =

> CallHistoryAdapter hierarchy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =

> Service 	: org.ofono
> Interface	: org.ofono.CallHistoryAdapter
> Object path	: freely definable

What is Adapter meaning here. Just CallHistory would be fine. And makes
is more consistent with STK Agent.

The object path is not freely definable. You do have to pick one.

> Methods		void RegisterAgent (objectpath)  =

> =

> 			RegisterAgent method registers the agent object path. Methods on this =
agent will be called if history needs to push data.  =

> =

> 			Possible Errors: [service].Error.InvalidArguments
> 					 [service].Error.InvalidFormat
> 					 [service].Error.InUse

What is InvalidFormat? Fair enough, you copied this from STK Agent and
it uses this for invalid object path. I don't even think this is needed
at all since the D-Bus system daemon will ensure this, but fair enough
leave that in since STK Agent is using it similar. Consistency is good.

> 		void UnregisterAgent (objectpath) =

> =

> 			UnregisterAgent method unregister the already registered agent object =
path.
> =

> 			Possible Errors: [service].Error.InvalidArguments
> 					 [service].Error.InvalidFormat
> 					 [service].Error.InUse
> =

> =

> CallHistoryAgent hierarchy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> =

> Service Name	: Unique Name
> Interface	: org.ofono.CallHistoryAgent
> Objectpath	: Freely definable
> =

> Methods		void SendHistory(array {struct {uint32,uint32,uint8,uint32,uint3=
2} }) =

> =

> 			This method gets called by ofono to deliver one record of voice call h=
istory.
> 		=

> 			Possible Errors: [service].Error.Unsuccessful

Yeah. No way. Use a dictionary. We are not modeling some weird memory
structure via D-Bus. That is not extendable at all.

> 		void SendCachedHistory(array {struct {uint32,uint32,uint8,uint32,uint32=
} })
> =

> 			This method gets called by the ofono when CallHistoryAgent starts runn=
ing. =

> 			It delivers all the history records as an array of structures.
> =

> 			Possible Errors: [service].Error.Unsuccessful

No.

One method for both here. If the client calls RegisterAgent then at that
point you start sending out the cached history. No need to make a
differentiation here. The client doesn't care. It just needs to get the
information.

> 		void Release() =

> 			Cleans up agent, assumes that agent is already unregistered, so not ne=
eded to unregister. =

> =

> CallHistory Record =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  =

> CallHistoryRecord {
> 		uint32	uid;
> 		uint8	voicecalltype;
> 		char	lineid[20];
> 		uint32	starttime;
> 		uint32	endtime;
> }
> =

> voicecalltype {
> 	outgoing =3D 0,
> 	incoming =3D 1,
> 	missed =3D 2
> }

Define proper dictionary key/type values pair like we do for property or
use inside the Messaging API already. Consistency.

	New immediate (class 0) SMS received. Info has Sender,
	LocalSentTime, and SentTime information.  Sender
	address is given in string format.  LocalSentTime and
	SentTime are given in string form using ISO8601 format.

So it defines already LocalSentTime, SentTime and Sender. And voicecall
already defines LineIdentifcation.

	Contains the Line Identification information returned
	by the network, if present. For incoming calls this is
	effectively the CLIP. For outgoing calls this attribute
	will hold the dialed number, or the COLP if received by
	the underlying implementation.

This could be all nicely re-used. I think you get the idea.

If the call history agent is a global agent, then you need to include
the modem object path here as well. So that a client could identify from
which modem this came. Over time the modem could change, but the IMSI
could stay the same. Or just include the IMSI here. We need to discuss
this, but keep it in mind.

Regards

Marcel



--===============1983780691509889659==--

