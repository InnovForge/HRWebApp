using Confluent.Kafka;
using Confluent.Kafka.Serialization;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

public class KafkaProducerService
{
    private readonly string _bootstrapServers = "localhost:9092";

    public Task SendMessageAsync(string topic, string message)
    {
        var config = new Dictionary<string, object>
        {
            { "bootstrap.servers", _bootstrapServers }
        };

        using (var producer = new Producer<Null, string>(config, null, new StringSerializer(System.Text.Encoding.UTF8)))
        {
            var result = producer.ProduceAsync(topic, null, message).Result;
            Console.WriteLine($"Delivered to: {result.TopicPartitionOffset}");
        }

        return Task.CompletedTask;
    }
}
