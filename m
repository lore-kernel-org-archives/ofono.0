Content-Type: multipart/mixed; boundary="===============9071766802443568555=="
MIME-Version: 1.0
From: rajyalakshmi bommaraju <rajyalakshmi.bommaraju@intel.com>
Subject: Re: Please comment on callhistory API
Date: Wed, 20 Oct 2010 16:38:47 -0700
Message-ID: <4CBF7D87.4020108@intel.com>
In-Reply-To: <1285918417.4231.7.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9071766802443568555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel,

Marcel Holtmann wrote:
> Hi Raji,
>
>   =

>>>>>> org.ofono.History will be the main adapter interface and =

>>>>>> org.ofono.CallHistoryAgent the callhistory agent and =

>>>>>> org.ofono.SmsHistoryAgent as the sms history agent. I want to sepera=
te =

>>>>>> the two agents so that sms app will expose sms history agent and dia=
ler =

>>>>>> will register and expose callhistory agent. Then it will be clear wh=
ich =

>>>>>> agent is interested in which history, vs one org.ofono.HistoryAgent =

>>>>>> exposing ReportCall and ReportTextMessage methods. In the later case =

>>>>>> adapter needs to flush both smshistory and callsistory onto two agen=
ts =

>>>>>> even though agents are not interested only in type of history.
>>>>>>     =

>>>>>>         =

>>>>>>             =

>>>>> actually not really. So why does the dialer and SMS application need =
to
>>>>> register for the history? Isn't that going to be stored central in
>>>>> Tracker or something similar. Should not be Tracker or some Tracker
>>>>> helper be registering the agent?
>>>>>   =

>>>>>       =

>>>>>           =

>>>> No, Dialer and Sms applications are the ones that read and stores =

>>>> locally, this will probably move to tracker eventually.
>>>> So I dont think we can assume that there is going to be a tracker agen=
t.
>>>>     =

>>>>         =

>>>>> I might be wrong, but does it really make sense to separate it on this
>>>>> level?
>>>>>   =

>>>>>       =

>>>>>           =

>>>> I am thinking by separating the applications will only register and ge=
t =

>>>> data they are interested in.
>>>>     =

>>>>         =

>>> so Denis and I had a long chat about this. And essentially the history
>>> agent concept is not really something that we should maintain long term.
>>> We need be able to Tracker to listen on the D-Bus system bus and have
>>> oFono history plugin send data directly to Tracker. The history plugin
>>> should track if Tracker is running or not. If not spool. Otherwise send
>>> data to Tracker directly. Everything else is a pretty much complicated
>>> design.
>>>
>>> However for a short term solution, you could do a history agent concept
>>> as part of a MeeGo specific plugin.
>>>
>>> So use org.ofono as D-Bus service name and com.meego.TelephonyHistory
>>> and com.meego.TelephonyHistoryAgent as interface names.
>>>
>>> The main object path is / since are not going to make this based on a
>>> per modem.
>>>
>>> Two method calls in the agent a) ReportVoiceCall a) ReportTextMessage
>>> and that is it in. In the info dict include the Modem property which
>>> points to the modem object this information originates from.
>>>       =

>>  For outgoing TextMessages, ofono updates the history plugin in two meth=
od calls, first all the text message history related properties msg id, mes=
sage , local received time,actual sent time, lineid and status=3D'Pending' =
and in another method ofono updates plugin with the status. Earlier design,=
 I sent out history record with pending status and  when I received  status=
 update I  used  'property changed'  signal for status update. But I use 'u=
int32,variant' type which is not consistent with the current ofono property=
 changed signal type. My questions,
>>  1) Are you ok with using signal for status update, this lets us send ou=
t history as soon as we receive them if the agent is running      =

>>
>>  2) If we want to avoid signal, then we can store the outgoing text mess=
age record until we receive the status update from ofono, combine them and =
send out in case of agent running. In case of agent not running we do this =
anyway. =

>>     =


Updated API is below.
> History hierarchy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> Service : org.ofono
> Interface : com.meego.TelephonyHistory
> Object path : /
>
> Methods void RegisterAgent (objectpath)
>
> RegisterAgent method registers the agent object path. Methods on this =

> agent will be called if history needs to push data.
>
> Possible Errors: [service].Error.InvalidArguments
> [service].Error.InvalidFormat
> [service].Error.InUse
>
> void UnregisterAgent (objectpath)
>
> UnregisterAgent method unregister the already registered agent object =

> path.
>
> Possible Errors: [service].Error.InvalidArguments
> [service].Error.InvalidFormat
> [service].Error.InUse
>
>
> HistoryAgent hierarchy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> Service Name : Unique Name
> Interface : com.meego.TelephonyHistoryAgent
> Objectpath : Freely definable
>
> Methods void ReportTextMessage( array{dict})
>
> This method gets called by ofono to deliver an array of records. Each =

> record is represented as a dictionary, all the dict properties are =

> described in the "Properties" section.
>
> Possible Errors: [service].Error.Failed
>
> void ReportVoiceCall( array{dict})
>
> This method gets called by ofono to deliver an array of records. Each =

> record is represented as a dictionary, all the dict properties are =

> described in the "Properties" section.
>
> Possible Errors: [service].Error.Failed
>
> void Release()
> Cleans up agent, assumes that agent is already unregistered, so not =

> needed to unregister.
>
> Properties
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> uint32 Uid [Read Only]
> Integer representing the internal representation of histroy message id.
>
> string Type [Read Only]
> string representing the type of the history message. Type can be one =

> of the following three alternatives.
>
> "outgoing" - it is an outgoing history message
> "incoming" - it is an incoming history message
> "missed" - It is a history message for missed call
>
> string LineIdentification [Read Only]
> string representing the LineIdentification , for outgoing message it =

> is the phone number dialed. For incoming message it is the CLIP, or =

> COLP if received by the underlying implementation.
>
> String Message [Read Only]
> string represents the text message.
>
> string LocalSentTime [Read Only]
> String representing local sent time.
>
> string SentTime [Read Only]
> String representing sent time.
>
> string StartTime [Read Only]
> String representing start time of the call
>
> string EndTime [Read Only]
> String representing end time of the call
>
> dict Information [Read Only]
> dict representing modem path from which this message originates
> "Modem" - will fetch object path of the modem

> Thanks
>   =

Raji
_______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>   =




							History Adapter-Agent


	History is a built in plugin for ofono. It uses HistoryAgent api exposed b=
y client to push history information. HistoryAgent api is a service interfa=
ce exposed by client over dbus. Plugin exposes History interface that Histo=
ryAgent registers and unregisters with. if the HistoryAgent registers with =
History then plugin pushes the history information to agent soon as it rece=
ives from ofono, otherwise it caches the data in a disk file until agent re=
gisters, once agent registers plugin will read the data from the disk file =
and pushes all the records to it.

History: =


it is going to register and unregister the agent. It calls the methods on t=
he agent for delivering history information whent the agent is up and runni=
ng. The history record will be written to the disk if agent method returns =
error or if the agent is not running. For outgoing messages ofono hands ove=
r history to plugin in 2 calls. It calls the plugin with all the message hi=
story properties with 'Pending" status first and updates the status with an=
other method call. Plugin updates the messages history to client in 2 calls=
 using same ReportTextMessage method. =



History hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Service 	: org.ofono
Interface	: com.meego.TelephonyHistory
Object path	: /

Methods		void RegisterAgent (objectpath)  =


			RegisterAgent method registers the agent object path. Methods on this ag=
ent will be called if history needs to push data.  =


			Possible Errors: [service].Error.InvalidArguments
					 [service].Error.InvalidFormat
					 [service].Error.InUse

		void UnregisterAgent (objectpath) =


			UnregisterAgent method unregister the already registered agent object pa=
th.

			Possible Errors: [service].Error.InvalidArguments
					 [service].Error.InvalidFormat
					 [service].Error.InUse


HistoryAgent hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Service Name	: Unique Name
Interface	: com.meego.TelephonyHistoryAgent
Objectpath	: Freely definable

Methods		void ReportTextMessage( array{dict}) =


			This method gets called by ofono to deliver an array of records. Each re=
cord is represented as a dictionary, all the dict 				properties are descri=
bed in the "Properties" section.
		=

			Possible Errors: [service].Error.Failed

		void ReportVoiceCall( array{dict}) =


			This method gets called by ofono to deliver an array of records. Each re=
cord is represented as a dictionary, all the dict 				properties are descri=
bed in the "Properties" section.
		=

			Possible Errors: [service].Error.Failed
		=

		void Release() =

			Cleans up agent, assumes that agent is already unregistered, so not need=
ed to unregister.

Properties =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=

		uint32	Uid [Read Only]
			Integer representing the internal representation of histroy message id.

		string  Type [Read Only]
			string representing the type of the history message. Type can be one of =
the following three alternatives.
 =

			"outgoing" - it is an outgoing history message =

			"incoming" - it is an incoming history message
			"missed" - It is a history message for missed call
			=

		string	LineIdentification [Read Only]
			string representing the LineIdentification , for outgoing message it is =
the phone number dialed. For incoming message it is the 			CLIP, or COLP if=
 received by the underlying implementation.

		String  Message [Read Only]
			string represents the text message.

		string	LocalSentTime [Read Only]
			String representing local sent time. =


		string	SentTime [Read Only]
			String representing sent time.

		string  StartTime [Read Only]
 			String representing start time of the call

 		string  EndTime [Read Only]
 			String representing end time of the call
			=

		dict	Information [Read Only]
			dict representing modem path from which this message originates
			"Modem" - will fetch object path of the modem=20

--===============9071766802443568555==--

