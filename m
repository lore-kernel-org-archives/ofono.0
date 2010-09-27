Content-Type: multipart/mixed; boundary="===============5803124305991951295=="
MIME-Version: 1.0
From: rajyalakshmi bommaraju <rajyalakshmi.bommaraju@intel.com>
Subject: Re: Please comment on callhistory API
Date: Mon, 27 Sep 2010 13:38:55 -0700
Message-ID: <4CA100DF.40402@intel.com>
In-Reply-To: <1285609846.9845.11.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5803124305991951295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel,

org.ofono.History will be the main adapter interface and =

org.ofono.CallHistoryAgent the callhistory agent and =

org.ofono.SmsHistoryAgent as the sms history agent. I want to seperate =

the two agents so that sms app will expose sms history agent and dialer =

will register and expose callhistory agent. Then it will be clear which =

agent is interested in which history, vs one org.ofono.HistoryAgent =

exposing ReportCall and ReportTextMessage methods. In the later case =

adapter needs to flush both smshistory and callsistory onto two agents =

even though agents are not interested only in type of history.

Does it sound reasonable?
Thanks,
Raji

Marcel Holtmann wrote:
> Hi Raji,
>
>   =

>> CallHistory hierarchy
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Service : org.ofono
>> Interface : org.ofono.CallHistory
>> Object path : [variable prefix]/{modem0,modem1,...}/CallHistory
>>     =

>
> the object path is wrong here. This should be pretty much on the main /
> object path. And not on per modem and not in a sub-path.
>
> I really don't think that per modem history makes sense. Denis?
>
>   =

>> Methods 	void RegisterAgent (objectpath)
>>
>> 			RegisterAgent method registers the agent object path. Methods on this =

>> 			agent will be called if history needs to push data.
>>
>> 			Possible Errors: [service].Error.InvalidArguments
>> 			[service].Error.InvalidFormat
>> 			[service].Error.InUse
>>
>> 		void UnregisterAgent (objectpath)
>>
>> 			UnregisterAgent method unregister the already registered agent object=
 path.
>>
>> 			Possible Errors: [service].Error.InvalidArguments
>> 			[service].Error.InvalidFormat
>> 			[service].Error.InUse
>>
>> CallHistoryAgent hierarchy
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Service Name : Unique Name
>> Interface : org.ofono.CallHistoryAgent
>> Objectpath : Freely definable
>>     =

>
> So I am actually thinking this should be just History and HistoryAgent
> interfaces. Since we can differentiate between different types by the
> different methods in the agent.
>
>   =

>> Methods 	void SendHistory( array{dict})
>>
>> 			This method gets called by ofono to deliver an array of records. Each =

>> 			record is represented as a dictionary, all the dict properties are =

>> 			described in the "Properties" section.
>>
>> 			Possible Errors: [service].Error.Unsuccessful
>>     =

>
> We have to do some semantical things here first. So you proposal here is
> to do org.ofono.CallHistoryAgent.SendHistory. The "History" part is used
> twice here. That is never a good idea. Also it is not really sending a
> history per se. It is more reporting one and just one at a time. So it
> is not history it reports, it is a call.
>
> So my proposal here is just to have one method for ReportCall and
> another one for ReportTextMessage etc.
>
>   =

>> 		void Release()
>> 			Cleans up agent, assumes that agent is already unregistered, so not =

>> 			needed to unregister.
>>
>> Properties
>> =3D=3D=3D=3D=3D=3D=3D
>> 		integer Uid [Read Only]
>> 			Integer representing the unique id of the history record
>>     =

>
> In this case I would prefer UID as value and in uint32 please. D-Bus
> doesn't have an integer type.
>
> Also do we actually need this? Denis?
>
>   =

>> 		string Calltype [Read Only]
>> 			string representing the call type. Call type can be one of the follow=
ing =

>> 			three alternatives
>> 			"outgoing" - it is an outgoing call
>> 			"incoming" - it is an incoming call
>> 			"missed" - it is a missed call
>>     =

>
> If is is the call history dict then just Type is good enough. No idea to
> duplicate the work Call all over the place.
>
>   =

>> 		string LineIdentification [Read Only]
>> 			string representing the LineIdentification , for outgoing call it is =
the =

>> 			phone number dialed. For Incoming call it is the CLIP, or COLP if =

>> 			received by the underlying implementation.
>>
>> 		string StartTime [Read Only]
>> 			String representing start time of the call
>>
>> 		string EndTime [Read Only]
>> 			String representing end time of the call
>>     =

>
> These looks fine.
>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>   =



--===============5803124305991951295==--

