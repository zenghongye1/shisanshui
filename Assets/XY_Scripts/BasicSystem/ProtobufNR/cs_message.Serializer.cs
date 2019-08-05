﻿// This is the backend code for reading and writing

// Generated by ProtocolBuffer
// - a pure c# code generation implementation of protocol buffers
// Report bugs to: https://silentorbit.com/protobuf/

// DO NOT EDIT
// This file will be overwritten when CodeGenerator is run.
using System;
using System.IO;
using System.Text;
using System.Collections.Generic;

namespace cs
{
    public partial class CSPkgHead
    {
        /// <summary>Helper: create a new instance to deserializing into</summary>
        public static CSPkgHead Deserialize(Stream stream)
        {
            var instance = new CSPkgHead();
            Deserialize(stream, instance);
            return instance;
        }

        /// <summary>Helper: create a new instance to deserializing into</summary>
        public static CSPkgHead DeserializeLengthDelimited(Stream stream)
        {
            var instance = new CSPkgHead();
            DeserializeLengthDelimited(stream, instance);
            return instance;
        }

        /// <summary>Helper: create a new instance to deserializing into</summary>
        public static CSPkgHead DeserializeLength(Stream stream, int length)
        {
            var instance = new CSPkgHead();
            DeserializeLength(stream, length, instance);
            return instance;
        }

        /// <summary>Helper: put the buffer into a MemoryStream and create a new instance to deserializing into</summary>
        public static CSPkgHead Deserialize(byte[] buffer)
        {
            var instance = new CSPkgHead();
            using (var ms = new MemoryStream(buffer))
                Deserialize(ms, instance);
            return instance;
        }

        /// <summary>Helper: put the buffer into a MemoryStream before deserializing</summary>
        public static global::cs.CSPkgHead Deserialize(byte[] buffer, global::cs.CSPkgHead instance)
        {
            using (var ms = new MemoryStream(buffer))
                Deserialize(ms, instance);
            return instance;
        }

        /// <summary>Takes the remaining content of the stream and deserialze it into the instance.</summary>
        public static global::cs.CSPkgHead Deserialize(Stream stream, global::cs.CSPkgHead instance)
        {
            while (true)
            {
                int keyByte = stream.ReadByte();
                if (keyByte == -1)
                    break;
                // Optimized reading of known fields with field ID < 16
                switch (keyByte)
                {
                    // Field 1 Varint
                    case 8:
                        instance.CmdID = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadString(stream);
                        continue;
                    // Field 2 Varint
                    case 16:
                        instance.MsgSeqID = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
                        continue;
                    // Field 3 Varint
                    case 24:
                        instance.NotifyMsgSeqID = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
                        continue;
                    // Field 4 Varint
                    case 32:
                        instance.EncryptCompressType = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
                        continue;
                }

                var key = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadKey((byte)keyByte, stream);

                // Reading field ID > 16 and unknown field ID/wire type combinations
                switch (key.Field)
                {
                    case 0:
                        throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Invalid field id: 0, something went wrong in the stream");
                    default:
                        global::SilentOrbit.ProtocolBuffers.ProtocolParser.SkipKey(stream, key);
                        break;
                }
            }

            return instance;
        }

        /// <summary>Read the VarInt length prefix and the given number of bytes from the stream and deserialze it into the instance.</summary>
        public static global::cs.CSPkgHead DeserializeLengthDelimited(Stream stream, global::cs.CSPkgHead instance)
        {
            long limit = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
            limit += stream.Position;
            while (true)
            {
                if (stream.Position >= limit)
                {
                    if (stream.Position == limit)
                        break;
                    else
                        throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Read past max limit");
                }
                int keyByte = stream.ReadByte();
                if (keyByte == -1)
                    throw new System.IO.EndOfStreamException();
                // Optimized reading of known fields with field ID < 16
                switch (keyByte)
                {
                    // Field 1 Varint
                    case 8:
                        instance.CmdID = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadString(stream);
                        continue;
                    // Field 2 Varint
                    case 16:
                        instance.MsgSeqID = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
                        continue;
                    // Field 3 Varint
                    case 24:
                        instance.NotifyMsgSeqID = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
                        continue;
                    // Field 4 Varint
                    case 32:
                        instance.EncryptCompressType = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
                        continue;
                }

                var key = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadKey((byte)keyByte, stream);

                // Reading field ID > 16 and unknown field ID/wire type combinations
                switch (key.Field)
                {
                    case 0:
                        throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Invalid field id: 0, something went wrong in the stream");
                    default:
                        global::SilentOrbit.ProtocolBuffers.ProtocolParser.SkipKey(stream, key);
                        break;
                }
            }

            return instance;
        }

        /// <summary>Read the given number of bytes from the stream and deserialze it into the instance.</summary>
        public static global::cs.CSPkgHead DeserializeLength(Stream stream, int length, global::cs.CSPkgHead instance)
        {
            long limit = stream.Position + length;
            while (true)
            {
                if (stream.Position >= limit)
                {
                    if (stream.Position == limit)
                        break;
                    else
                        throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Read past max limit");
                }
                int keyByte = stream.ReadByte();
                if (keyByte == -1)
                    throw new System.IO.EndOfStreamException();
                // Optimized reading of known fields with field ID < 16
                switch (keyByte)
                {
                    // Field 1 Varint
                    case 8:
                        instance.CmdID = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadString(stream);
                        continue;
                    // Field 2 Varint
                    case 16:
                        instance.MsgSeqID = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
                        continue;
                    // Field 3 Varint
                    case 24:
                        instance.NotifyMsgSeqID = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
                        continue;
                    // Field 4 Varint
                    case 32:
                        instance.EncryptCompressType = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
                        continue;
                }

                var key = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadKey((byte)keyByte, stream);

                // Reading field ID > 16 and unknown field ID/wire type combinations
                switch (key.Field)
                {
                    case 0:
                        throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Invalid field id: 0, something went wrong in the stream");
                    default:
                        global::SilentOrbit.ProtocolBuffers.ProtocolParser.SkipKey(stream, key);
                        break;
                }
            }

            return instance;
        }

        [ThreadStatic]
        static global::SilentOrbit.ProtocolBuffers.MemoryStreamStack stack = new global::SilentOrbit.ProtocolBuffers.ThreadUnsafeStack();
        /// <summary>Serialize the instance into the stream</summary>
        public static void Serialize(Stream stream, CSPkgHead instance)
        {
            var msField = stack.Pop();
            // Key for field: 1, Varint
            stream.WriteByte(8);
            global::SilentOrbit.ProtocolBuffers.ProtocolParser.WriteString(stream, instance.CmdID);
            // Key for field: 2, Varint
            stream.WriteByte(16);
            global::SilentOrbit.ProtocolBuffers.ProtocolParser.WriteUInt32(stream, instance.MsgSeqID);
            // Key for field: 3, Varint
            stream.WriteByte(24);
            global::SilentOrbit.ProtocolBuffers.ProtocolParser.WriteUInt32(stream, instance.NotifyMsgSeqID);
            // Key for field: 4, Varint
            stream.WriteByte(32);
            global::SilentOrbit.ProtocolBuffers.ProtocolParser.WriteUInt32(stream, instance.EncryptCompressType);
            stack.Push(msField);
        }

        /// <summary>Helper: Serialize into a MemoryStream and return its byte array</summary>
        public static byte[] SerializeToBytes(CSPkgHead instance)
        {
            using (var ms = new MemoryStream())
            {
                Serialize(ms, instance);
                return ms.ToArray();
            }
        }
        /// <summary>Helper: Serialize with a varint length prefix</summary>
        public static void SerializeLengthDelimited(Stream stream, CSPkgHead instance)
        {
            var data = SerializeToBytes(instance);
            global::SilentOrbit.ProtocolBuffers.ProtocolParser.WriteUInt32(stream, (uint)data.Length);
            stream.Write(data, 0, data.Length);
        }
    }

    public partial class CSPKG
    {
        /// <summary>Helper: create a new instance to deserializing into</summary>
        public static CSPKG Deserialize(Stream stream)
        {
            var instance = new CSPKG();
            Deserialize(stream, instance);
            return instance;
        }

        /// <summary>Helper: create a new instance to deserializing into</summary>
        public static CSPKG DeserializeLengthDelimited(Stream stream)
        {
            var instance = new CSPKG();
            DeserializeLengthDelimited(stream, instance);
            return instance;
        }

        /// <summary>Helper: create a new instance to deserializing into</summary>
        public static CSPKG DeserializeLength(Stream stream, int length)
        {
            var instance = new CSPKG();
            DeserializeLength(stream, length, instance);
            return instance;
        }

        /// <summary>Helper: put the buffer into a MemoryStream and create a new instance to deserializing into</summary>
        public static CSPKG Deserialize(byte[] buffer)
        {
            var instance = new CSPKG();
            using (var ms = new MemoryStream(buffer))
                Deserialize(ms, instance);
            return instance;
        }

        /// <summary>Helper: put the buffer into a MemoryStream before deserializing</summary>
        public static global::cs.CSPKG Deserialize(byte[] buffer, global::cs.CSPKG instance)
        {
            using (var ms = new MemoryStream(buffer))
                Deserialize(ms, instance);
            return instance;
        }

        /// <summary>Takes the remaining content of the stream and deserialze it into the instance.</summary>
        public static global::cs.CSPKG Deserialize(Stream stream, global::cs.CSPKG instance)
        {
            while (true)
            {
                int keyByte = stream.ReadByte();
                if (keyByte == -1)
                    break;
                // Optimized reading of known fields with field ID < 16
                switch (keyByte)
                {
                    // Field 1 LengthDelimited
                    case 10:
                        if (instance.Head == null)
                            instance.Head = global::cs.CSPkgHead.DeserializeLengthDelimited(stream);
                        else
                            global::cs.CSPkgHead.DeserializeLengthDelimited(stream, instance.Head);
                        continue;
                    // Field 2 LengthDelimited
                    case 18:
                        instance.Body = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadBytes(stream);
                        continue;
                }

                var key = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadKey((byte)keyByte, stream);

                // Reading field ID > 16 and unknown field ID/wire type combinations
                switch (key.Field)
                {
                    case 0:
                        throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Invalid field id: 0, something went wrong in the stream");
                    default:
                        global::SilentOrbit.ProtocolBuffers.ProtocolParser.SkipKey(stream, key);
                        break;
                }
            }

            return instance;
        }

        /// <summary>Read the VarInt length prefix and the given number of bytes from the stream and deserialze it into the instance.</summary>
        public static global::cs.CSPKG DeserializeLengthDelimited(Stream stream, global::cs.CSPKG instance)
        {
            long limit = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadUInt32(stream);
            limit += stream.Position;
            while (true)
            {
                if (stream.Position >= limit)
                {
                    if (stream.Position == limit)
                        break;
                    else
                        throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Read past max limit");
                }
                int keyByte = stream.ReadByte();
                if (keyByte == -1)
                    throw new System.IO.EndOfStreamException();
                // Optimized reading of known fields with field ID < 16
                switch (keyByte)
                {
                    // Field 1 LengthDelimited
                    case 10:
                        if (instance.Head == null)
                            instance.Head = global::cs.CSPkgHead.DeserializeLengthDelimited(stream);
                        else
                            global::cs.CSPkgHead.DeserializeLengthDelimited(stream, instance.Head);
                        continue;
                    // Field 2 LengthDelimited
                    case 18:
                        instance.Body = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadBytes(stream);
                        continue;
                }

                var key = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadKey((byte)keyByte, stream);

                // Reading field ID > 16 and unknown field ID/wire type combinations
                switch (key.Field)
                {
                    case 0:
                        throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Invalid field id: 0, something went wrong in the stream");
                    default:
                        global::SilentOrbit.ProtocolBuffers.ProtocolParser.SkipKey(stream, key);
                        break;
                }
            }

            return instance;
        }

        /// <summary>Read the given number of bytes from the stream and deserialze it into the instance.</summary>
        public static global::cs.CSPKG DeserializeLength(Stream stream, int length, global::cs.CSPKG instance)
        {
            long limit = stream.Position + length;
            while (true)
            {
                if (stream.Position >= limit)
                {
                    if (stream.Position == limit)
                        break;
                    else
                        throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Read past max limit");
                }
                int keyByte = stream.ReadByte();
                if (keyByte == -1)
                    throw new System.IO.EndOfStreamException();
                // Optimized reading of known fields with field ID < 16
                switch (keyByte)
                {
                    // Field 1 LengthDelimited
                    case 10:
                        if (instance.Head == null)
                            instance.Head = global::cs.CSPkgHead.DeserializeLengthDelimited(stream);
                        else
                            global::cs.CSPkgHead.DeserializeLengthDelimited(stream, instance.Head);
                        continue;
                    // Field 2 LengthDelimited
                    case 18:
                        instance.Body = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadBytes(stream);
                        continue;
                }

                var key = global::SilentOrbit.ProtocolBuffers.ProtocolParser.ReadKey((byte)keyByte, stream);

                // Reading field ID > 16 and unknown field ID/wire type combinations
                switch (key.Field)
                {
                    case 0:
                        throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Invalid field id: 0, something went wrong in the stream");
                    default:
                        global::SilentOrbit.ProtocolBuffers.ProtocolParser.SkipKey(stream, key);
                        break;
                }
            }

            return instance;
        }

        [ThreadStatic]
        static global::SilentOrbit.ProtocolBuffers.MemoryStreamStack stack = new global::SilentOrbit.ProtocolBuffers.ThreadUnsafeStack();
        /// <summary>Serialize the instance into the stream</summary>
        public static void Serialize(Stream stream, CSPKG instance)
        {
            var msField = stack.Pop();
            if (instance.Head == null)
                throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Head is required by the proto specification.");
            // Key for field: 1, LengthDelimited
            stream.WriteByte(10);
            ﻿msField.SetLength(0);
            global::cs.CSPkgHead.Serialize(msField, instance.Head);
            // Length delimited byte array
            uint length1 = (uint)msField.Length;
            global::SilentOrbit.ProtocolBuffers.ProtocolParser.WriteUInt32(stream, length1);
            msField.WriteTo(stream);

            if (instance.Body == null)
                throw new global::SilentOrbit.ProtocolBuffers.ProtocolBufferException("Body is required by the proto specification.");
            // Key for field: 2, LengthDelimited
            stream.WriteByte(18);
            global::SilentOrbit.ProtocolBuffers.ProtocolParser.WriteBytes(stream, instance.Body);
            stack.Push(msField);
        }

        /// <summary>Helper: Serialize into a MemoryStream and return its byte array</summary>
        public static byte[] SerializeToBytes(CSPKG instance)
        {
            using (var ms = new MemoryStream())
            {
                Serialize(ms, instance);
                return ms.ToArray();
            }
        }
        /// <summary>Helper: Serialize with a varint length prefix</summary>
        public static void SerializeLengthDelimited(Stream stream, CSPKG instance)
        {
            var data = SerializeToBytes(instance);
            global::SilentOrbit.ProtocolBuffers.ProtocolParser.WriteUInt32(stream, (uint)data.Length);
            stream.Write(data, 0, data.Length);
        }
    }

}